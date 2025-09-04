import { Quest } from "./types/quest";
import { onDocumentWritten } from "firebase-functions/v2/firestore";

export const actorQueueSentinel = onDocumentWritten(
  {
    document: "quests/{questId}/queue/{userId}",
    region: "europe-west3",
  },
  async (event) => {
    const change = event.data;
    if (!change) return;
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
