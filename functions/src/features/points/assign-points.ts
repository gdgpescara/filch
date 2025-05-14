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

    // If the type is staff or community remove
    // from users if they have already assigned points.
    const filteredUsers = [];
    if (type == PointsTypeEnum.staff || type == PointsTypeEnum.community) {
      const batch = getFirestore().batch();
      for (const user of users) {
        const userPointSnap = await getFirestore()
          .collection("users")
          .doc(user.uid)
          .collection("points")
          .where("type", "==", type)
          .get();
        if (userPointSnap.docs.length > 0) {
          logger.info("User: " + user.uid + " already has points");
        } else {
          filteredUsers.push(user);
        }
      }
      await batch.commit();
    } else {
      filteredUsers.push(...users);
    }

    const points = <Points>{
      type: type,
      points: assignedPoints,
      assignedBy: loggedUser.uid,
      assignedAt: Timestamp.now(),
      quest: questId,
    };

    logger.info("Points: " + JSON.stringify(points));

    const batch = getFirestore().batch();
    for (const user of filteredUsers) {
      const userPoints = {...points};
      batch.set(
        getFirestore()
          .collection("users")
          .doc(user.uid)
          .collection("points")
          .doc(),
        userPoints,
      );
      if (type == PointsTypeEnum.quest && questId) {
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
    if (type == PointsTypeEnum.quest && questId) {
      const decodedId = questId.split("-");
      if (decodedId.length === 3 && decodedId[0] === "actor") {
        const questTimelineDocRef = await getFirestore()
          .collection("timelines")
          .doc(decodedId[1]);
        const questTimelineDoc = await questTimelineDocRef.get();
        batch.set(questTimelineDocRef, {
          count: questTimelineDoc.data()?.count + 1,
        });
      }
    }
    await batch.commit();

    return true;
  }
);
