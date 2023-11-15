import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "./types/points";
import {getAuth} from "firebase-admin/auth";
import {PointsTypeEnum} from "./types/points-type-enum";
import {ActiveQuest} from "../quests/types/active-quest";

export const assignPoints = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const assignedPoints = request.data.points;
    const type = request.data.type;
    const questId = request.data.quest;
    const users = await Promise.all(
      request.data.users
        .map(async (uid: string) => await getAuth().getUser(uid)),
    );

    // Calculate group groupMultiplier
    let groupMultiplier = 1;
    if (users.length > 1) {
      const houses = users.map((user) => user.customClaims?.["house"]);
      if ([...new Set(houses)].length === 1) {
        groupMultiplier = 1.25;
      } else {
        groupMultiplier = 1.5;
      }
    }

    const points = <Points>{
      type: type,
      points: Math.round(assignedPoints * groupMultiplier),
      assignedBy: loggedUser.uid,
      assignedAt: Timestamp.now(),
      quest: questId,
    };

    const batch = getFirestore().batch();
    for (const user of users) {
      const isNimbusUser = user.customClaims?.["isNimbusUser"] ?? false;
      let userPoints = {...points};
      if (isNimbusUser) {
        userPoints = {...points, points: Math.round(points.points * 1.3)};
      }
      batch.set(
        getFirestore()
          .collection("users")
          .doc(user.uid)
          .collection("points")
          .doc(),
        userPoints,
      );
      batch.set(
        getFirestore()
          .collection("houses")
          .doc(user.customClaims?.["house"])
          .collection("members")
          .doc(user.uid)
          .collection("points")
          .doc(),
        userPoints,
      );
      if (type == PointsTypeEnum.quest) {
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
