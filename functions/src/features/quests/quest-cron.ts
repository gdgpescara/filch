// Cron that clean all active quest expired

import {onSchedule} from "firebase-functions/v2/scheduler";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {QuestTypeEnum} from "./types/quest-type-enum";
import {QueueItem} from "./types/queue-item";
import {Quest} from "./types/quest";
import {ActiveQuest} from "./types/active-quest";

export const activeQuestsCleaner = onSchedule({
  schedule: "every 1 minutes",
  timeZone: "Europe/Rome",
  region: "europe-west3",
}, async () => {
  // Clean all active quest queue
  const quests = await getFirestore()
    .collection("quests")
    .where("questType", "==", QuestTypeEnum.actor)
    .get();
  const batch = getFirestore().batch();
  for (const questSnap of quests.docs) {
    const quest = <Quest>{...questSnap.data()};
    const queueSnap = await questSnap.ref.collection("queue").get();
    const queue = queueSnap.docs;
    const groupSize = quest.groupSize ?? 0;
    if (groupSize > queue.length) {
      return;
    }
    if (groupSize == queue.length) {
      batch.update(questSnap.ref, {queueAt: Timestamp.now()});
      return;
    }
    for (const queueItemSnap of queue) {
      const queueItem = <QueueItem>{...queueItemSnap.data()};
      const d = new Date().getTime() - queueItem.queuedAt.toDate().getTime();
      if (quest.queueTime == null) {
        continue;
      }
      const maxTime = quest.queueTime * 60 * 1000;
      if (d > maxTime) {
        batch.delete(queueItemSnap.ref);
      }
    }
  }

  // Clean all active quest
  const usersWithActiveQuest = await getFirestore()
    .collection("users")
    .where("activeQuest", "!=", null)
    .get();
  for (const user of usersWithActiveQuest.docs) {
    const activeQuest = user.data().activeQuest as ActiveQuest;
    const d = new Date().getTime() - activeQuest.activatedAt.toDate().getTime();
    if (activeQuest.quest.type == QuestTypeEnum.actor) {
      const queueSnap = await getFirestore()
        .collection("quests")
        .doc(activeQuest.quest.id)
        .collection("queue")
        .get();
      const queue = queueSnap.docs;
      const groupSize = activeQuest.quest.groupSize ?? 0;
      if (groupSize > queue.length) {
        continue;
      }
    }
    if (d > activeQuest.quest.executionTime * 60 * 1000) {
      batch.update(user.ref, {activeQuest: null});
    }
  }
  await batch.commit();
});
