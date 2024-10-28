import {onSchedule} from "firebase-functions/v2/scheduler";
import {logger} from "firebase-functions/v2";
import {getFirestore} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";

const poolSize = 100;

export const sendTShirtNotification = async () => {
  try {
    const usersSnap = await getFirestore()
      .collection("users")
      .where("tShirtPickupRequested", "==", false)
      .where("tShirtPickup", "==", false)
      .where("isStaff", "==", false)
      .where("fcmToken", "!=", null)
      .get();

    const users = usersSnap.docs.sort(() => Math.random() - Math.random())
      .slice(0, poolSize).map((doc) => {
        return {
          fcmToken: doc.data().fcmToken,
          id: doc.id,
        };
      });

    if (users.length === 0) {
      logger.info("🚫 No users to send notifications to");
      return;
    }

    logger.info("📩 Sending notifications to:", users.length, "users");

    for (const user of users) {
      logger.info("📲 Sending notification to: ", user.id,
        "with token:", user.fcmToken);
      const message = {
        notification: {
          title: "Hey, it's time to pick up your t-shirt!",
          // eslint-disable-next-line max-len
          body: "Got to the gadget desk and ask to the staff for your t-shirt. Enjoy it!",
        },
        token: user.fcmToken,
      };

      try {
        await getMessaging().send(message);

        await getFirestore().collection("users").doc(user.id).update({
          tShirtPickupRequested: true,
        });

        logger.info("✅  Notification sent to: ", user.id);
      } catch (error) {
        logger.error("‼️ An error occurred when sending notification to: ",
          user.id, ":", error);
      }
    }
  } catch (parseError) {
    logger.error("‼️ Error parsing the JSON data:", parseError);
  }
};

export const tShirtNotificationSchedule = onSchedule({
  schedule: "every 1 hours",
  timeZone: "Europe/Rome",
  region: "europe-west3",
}, async () => {
  await sendTShirtNotification();
});
