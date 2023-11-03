// Cron that clean all active quest expired

import {onSchedule} from "firebase-functions/v2/scheduler";
import {getFirestore} from "firebase-admin/firestore";
import {ActiveQuest} from "./types/active-quest";
import {QuestTypeEnum} from "./types/quest-type-enum";
import {QueueItem} from "./types/queue-item";
import {Quest} from "./types/quest";

/**
 * This cron clean all active quest expired.
 * To do this, it searches all users with active quest and checks
 * if the quest is expired.
 */
export const expiredActiveQuestCleaner = onSchedule({
  schedule: "every 1 minutes",
  timeZone: "Europe/Rome",
  region: "europe-west3",
}, async () => {
  const usersWithActiveQuest = await getFirestore()
    .collection("users")
    .where("activeQuest", "!=", null)
    .get();
  for (const user of usersWithActiveQuest.docs) {
    const activeQuest = user.data().activeQuest as ActiveQuest;
    const d = new Date().getTime() - activeQuest.activatedAt.toDate().getTime();
    if (d > activeQuest.quest.executionTime * 60 * 1000) {
      await user.ref.update({activeQuest: null});
    }
  }
});

/**
 * This cron clean all quest queue expired.
 * To do this, it searches all quests with questType actor and checks
 * in the queue subcollection if the queueItem is expired.
 */
export const questQueueCleaner = onSchedule({
  schedule: "every 1 minutes",
  timeZone: "Europe/Rome",
  region: "europe-west3",
}, async () => {
  const quests = await getFirestore()
    .collection("quests")
    .where("questType", "==", QuestTypeEnum.actor)
    .get();
  for (const questSnap of quests.docs) {
    const quest = <Quest>{...questSnap.data()};
    const queue = await questSnap.ref.collection("queue").get();
    for (const queueItemSnap of queue.docs) {
      const queueItem = <QueueItem>{...queueItemSnap.data()};
      const d = new Date().getTime() - queueItem.queuedAt.toDate().getTime();
      if (quest.queueTime == null) {
        continue;
      }
      const maxTime = quest.queueTime * 60 * 1000;
      if (d > maxTime) {
        await queueItemSnap.ref.delete();
      }
    }
  }
});
