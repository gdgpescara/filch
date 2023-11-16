import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore} from "firebase-admin/firestore";
import {ActiveQuest} from "./types/active-quest";
import {QuestTypeEnum} from "./types/quest-type-enum";

export const removeActiveQuest = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const userSnap = await getFirestore()
      .collection("users")
      .doc(loggedUser.uid)
      .get();
    const firestoreUser = userSnap.data();
    if (!firestoreUser) {
      return false;
    }
    const activeQuest = firestoreUser.activeQuest as ActiveQuest | null;
    if (!activeQuest) {
      return false;
    }
    // If actor quest check queue
    if (activeQuest.quest.type === QuestTypeEnum.actor) {
      const questSnap = await getFirestore()
        .collection("quests")
        .doc(activeQuest.quest.id)
        .get();
      const quest = questSnap.data();
      if (quest?.queueCount < quest?.groupSize) {
        return false;
      }
    }

    const batch = getFirestore().batch();
    // remove user active quest
    batch.update(getFirestore().collection("users").doc(loggedUser.uid), {
      activeQuest: null,
    });
    // remove user from quest queue if quest is actor type
    if (activeQuest.quest.type === QuestTypeEnum.actor) {
      batch.delete(
        getFirestore()
          .collection("quests")
          .doc(activeQuest.quest.id)
          .collection("queue")
          .doc(loggedUser.uid)
      );
    }
    await batch.commit();

    return true;
  });
