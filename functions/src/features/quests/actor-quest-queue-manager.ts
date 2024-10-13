import * as functions from "firebase-functions/v1";
import {Quest} from "./types/quest";

export const actorQueueSentinel = functions
  .region("europe-west3")
  .firestore
  .document("quests/{questId}/queue/{userId}")
  .onWrite(async (change) => {
    const queueCount = await change.after.ref.parent.count().get();
    const questRef = change.after.ref.parent.parent;
    if (questRef) {
      const questSnap = await questRef.get();
      const quest = questSnap.data() as Quest;
      if (questSnap.exists && quest.maxQueue == queueCount.data().count) {
        await questRef.update({
          requestAccepted: false,
          queueCount: queueCount.data().count,
        });
      } else {
        await questRef.update({
          queueCount: queueCount.data().count,
          requestAccepted: true,
        });
      }
    }
  });
