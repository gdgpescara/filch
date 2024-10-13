import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "../points/types/points";
import {PointsTypeEnum} from "../points/types/points-type-enum";
import {logger} from "firebase-functions/v2";
import {getAuth} from "firebase-admin/auth";

export type ScanOtherAttendeePayload = {
  points: number;
  scannedValue: string;
}

export const scanOtherAttendee = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const payload = <ScanOtherAttendeePayload>{...request.data};

    const scannedUser = await getAuth()
      .getUser(JSON.parse(payload.scannedValue).uid);
    if (scannedUser) {
      const userPointSnap = await getFirestore()
        .collection("users")
        .doc(loggedUser.uid)
        .collection("points")
        .where("type", "==", PointsTypeEnum.quest)
        .where("assignedFrom", "==", scannedUser.uid)
        .get();

      if (userPointSnap.docs.length > 0) {
        throw new Error("You have already scanned this user");
      }

      const points = <Points>{
        points: payload.points,
        type: PointsTypeEnum.quest,
        assignedAt: Timestamp.now(),
        assignedFrom: scannedUser.uid,
      };

      const batch = getFirestore().batch();
      batch.set(
        getFirestore()
          .collection("users")
          .doc(loggedUser.uid)
          .collection("points")
          .doc(),
        points,
      );
      await batch.commit();
      logger.info("Points added");
      return true;
    }
    logger.info("Scanned user not found");
    return false;
  }
);
