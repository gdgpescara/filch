import logging
from typing import List, Dict, Any
from datetime import datetime
from firebase_functions import scheduler_fn
from firebase_admin import firestore, messaging
from google.cloud.firestore_v1.base_query import FieldFilter
from shared.env import FIREBASE_REGION
from shared.localization import get_localized_string
from features.user.types import TShirtConfiguration


async def send_t_shirt_notification() -> None:
    """
    Function to send t-shirt pickup notifications to users.
    Selects users based on configuration settings and sends FCM notifications.
    """
    try:
        # Get t-shirt configuration from Firestore
        config_ref = firestore.client().collection(
            "configurations").document("t-shirt")
        config_doc = config_ref.get()

        if not config_doc.exists:
            logging.error("‼️ Configuration document not found")
            return

        # Convert Firestore document to our model
        config_data = config_doc.to_dict()
        t_shirt_config = TShirtConfiguration.from_dict(config_data)

        if not t_shirt_config.t_shirt_pickup_enabled:
            logging.info("🚫 T-shirt pickup notifications are disabled")
            return

        # Determine pool size based on current time
        pool_size = t_shirt_config.get_current_pool_size()

        # Query for eligible users
        users_query = (
            firestore.client()
            .collection("users")
            .where(filter=FieldFilter("tShirtPickupRequested", "==", False))
            .where(filter=FieldFilter("tShirtPickup", "==", False))
            .where(filter=FieldFilter("isStaff", "==", False))
            .where(filter=FieldFilter("fcmToken", "!=", None))
        )

        users_snap = users_query.get()

        if not users_snap:
            logging.info("🚫 No users to send notifications to")
            return

        # Randomly select users up to pool size
        import random
        shuffled_users = sorted(users_snap, key=lambda _: random.random())
        selected_users = shuffled_users[:pool_size]
        users_to_handle = [
            {"fcmToken": doc.get("fcmToken"), "id": doc.id, "language": doc.get("language", "en")}
            for doc in selected_users
        ]

        logging.info(
            f"📩 Sending notifications to: {len(users_to_handle)} users")

        # Send notifications to selected users
        for user in users_to_handle:
            logging.info(
                f"📲 Sending notification to: {user['id']} with token: {user['fcmToken']}")

            # Get localized notification strings based on user's language
            localized_strings = get_localized_string(user.get("language", "en"))
            
            message = messaging.Message(
                notification=messaging.Notification(
                    title=localized_strings["title"],
                    body=localized_strings["body"]
                ),
                token=user["fcmToken"]
            )

            try:
                # Send the message
                messaging.send(message)

                # Update user status
                firestore.client().collection("users").document(user["id"]).update({
                    "tShirtPickupRequested": True
                })

                logging.info(f"✅ Notification sent to: {user['id']}")
            except Exception as error:
                logging.error(
                    f"‼️ An error occurred when sending notification to: {user['id']}: {error}")

    except Exception as error:
        logging.error(f"‼️ Error processing t-shirt notifications: {error}")


@scheduler_fn.on_schedule(
    schedule="*/10 10-18 8,9 11 *",
    timezone="Europe/Rome",
    region=FIREBASE_REGION
)
def t_shirt_notification_schedule(event: scheduler_fn.ScheduledEvent) -> None:
    """
    Scheduled function that runs every 10 minutes between 10:00 and 18:00
    on November 8th and 9th to send t-shirt pickup notifications.
    """
    send_t_shirt_notification()
    logging.info("T-shirt notification schedule executed")
