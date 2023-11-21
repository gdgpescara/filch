import {onSchedule} from "firebase-functions/v2/scheduler";
import {getFirestore} from "firebase-admin/firestore";

export const removedQuestCron = onSchedule({
  schedule: "every 1 minutes",
  timeZone: "Europe/Rome",
  region: "europe-west3",
}, async () => {
  const users = await getFirestore()
    .collection("users")
    .get();
  const batch = getFirestore().batch();
  for (const user of users.docs) {
    const removedQuestsSnap = await user.ref.collection("removedQuests").get();
    for (const removedQuestSnap of removedQuestsSnap.docs) {
      const removedQuest = removedQuestSnap.data();
      const d = new Date().getTime() - removedQuest.addedAt.toDate().getTime();
      if (d > 10 * 60 * 1000) {
        batch.delete(removedQuestSnap.ref);
      }
    }
  }
  await batch.commit();
});
