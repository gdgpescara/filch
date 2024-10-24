import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "./types/points";
import {getAuth} from "firebase-admin/auth";
import {PointsTypeEnum} from "./types/points-type-enum";
import {ActiveQuest} from "../quests/types/active-quest";
import {logger} from "firebase-functions/v2";

export const assignPoints = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

    logger.info("Assigning points: " + JSON.stringify(request.data));

    const assignedPoints = request.data.points;
    const type = request.data.type;
    const questId = request.data.quest;
    const users = await Promise.all(
      request.data.users
        .map(async (uid: string) => await getAuth().getUser(uid)),
    );

    const points = <Points>{
      type: type,
      points: assignedPoints,
      assignedBy: loggedUser.uid,
      assignedAt: Timestamp.now(),
      quest: questId,
    };

    logger.info("Points: " + JSON.stringify(points));

    const batch = getFirestore().batch();
    for (const user of users) {
      const userPoints = {...points};
      batch.set(
        getFirestore()
          .collection("users")
          .doc(user.uid)
          .collection("points")
          .doc(),
        userPoints,
      );
      if (type == PointsTypeEnum.quest) {
        logger.info("Is quest points removing active quest and queue");
        const docRef = await getFirestore()
          .collection("users")
          .doc(user.uid)
          .get();
        const activeQuest = docRef.data()?.activeQuest as ActiveQuest;
        if (activeQuest.quest.id === questId) {
          batch.update(
            getFirestore().collection("users").doc(user.uid),
            {activeQuest: null}
          );
        }
        batch.delete(
          getFirestore()
            .collection("quests")
            .doc(questId)
            .collection("queue")
            .doc(user.uid)
        );
      }
    }
    await batch.commit();

    return true;
  }
);
