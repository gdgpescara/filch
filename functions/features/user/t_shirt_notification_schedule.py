from firebase_functions import scheduler_fn
from logger_config import logger
from firestore_client import client
from firebase_admin import messaging
from shared.env import (FIREBASE_REGION, TZ, START_DAY, END_DAY, MONTH, START_HOUR, END_HOUR, COLLECTION_CONFIGURATIONS,
                        COLLECTION_USER, DOCUMENT_TSHIRT)
import random
from datetime import datetime
from zoneinfo import ZoneInfo

EVERY_MINUTE = 1


def send_tshirt_notification():
    try:
        config_ref = client.collection(COLLECTION_CONFIGURATIONS).document(DOCUMENT_TSHIRT)
        config_doc = config_ref.get()

        if not config_doc.exists:
            logger.error("‼️ Configuration document not found")
            return

        config = config_doc.to_dict()

        if not config.get("tShirtPickupEnabled", False):
            logger.info("🚫 T-shirt pickup notifications are disabled")
            return

        default_pool = config.get("defaultPool", 0)
        boost_pool = config.get("boostPool", 0)
        boost_time_bands = config.get("boostTimeBands", [])

        now = datetime.now(ZoneInfo(TZ))
        is_boost_time = any(
            band["start"].to_datetime() <= now <= band["end"].to_datetime() for band in boost_time_bands)

        pool_size = boost_pool if is_boost_time else default_pool

        users_ref = (
            client.collection(COLLECTION_USER)
            .where("tShirtPickupRequested", "==", False)
            .where("tShirtPickup", "==", False)
            .where("staff", "==", False)
            .where("sponsor", "==", False)
            .where("fcmToken", "!=", None)
        )

        users_snap = users_ref.get()
        users = [
            {"id": doc.id, "fcmToken": doc.to_dict().get("fcmToken")}
            for doc in users_snap
        ]

        random.shuffle(users)
        users = users[:pool_size]

        if not users:
            logger.info("🚫 No users to send notifications to")
            return

        logger.info(f"📩 Sending notifications to {len(users)} users")

        for user in users:
            fcm_token = user["fcmToken"]
            user_id = user["id"]

            logger.info(f"📲 Sending notification to: {user_id} with token: {fcm_token}")

            message = messaging.Message(
                notification=messaging.Notification(
                    title="Hey, it's time to pick up your t-shirt!",
                    body="Go to the gadget desk and ask the staff for your t-shirt. Enjoy it!"
                ),
                token=fcm_token
            )

            try:
                messaging.send(message)
                client.collection(COLLECTION_USER).document(user_id).update({
                    "tShirtPickupRequested": True
                })
                logger.info(f"✅ Notification sent to: {user_id}")
            except Exception as e:
                logger.error(f"‼️ Error sending notification to {user_id}: {e}")

    except Exception as e:
        logger.error(f"‼️ Error parsing the JSON data: {e}")


if START_DAY == END_DAY:
    day_field = f"{START_DAY}"
else:
    day_field = f"{START_DAY}-{END_DAY}"

cron_schedule = f"*/{EVERY_MINUTE} {START_HOUR}-{END_HOUR} {day_field} {MONTH} *"


@scheduler_fn.on_schedule(schedule=cron_schedule, time_zone=TZ, region=FIREBASE_REGION)
def t_shirt_notification_schedule(event: scheduler_fn.ScheduledEvent):
    logger.info("Scheduled T-shirt notification job triggered")
    send_tshirt_notification()
