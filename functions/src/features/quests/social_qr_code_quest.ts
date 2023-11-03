import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "../points/types/points";
import {PointsTypeEnum} from "../points/types/points-type-enum";

export type ScanHouseMatePayload = {
  points: number;
  scannedValue: string;
}

export const scanHouseMate = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const payload = <ScanHouseMatePayload>{...request.data};

    const scannedUserSnap = await getFirestore()
      .collection("users")
      .doc(payload.scannedValue)
      .get();
    const scannedUser = scannedUserSnap.data();
    if (scannedUser) {
      const sameHouse = loggedUser.customClaims?.["house"] ===
        scannedUser.customClaims?.["house"];

      if (!sameHouse) {
        return false;
      }

      const points = <Points>{
        points: payload.points,
        type: PointsTypeEnum.quest,
        assignedAt: Timestamp.now(),
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
      batch.set(
        getFirestore()
          .collection("houses")
          .doc(loggedUser.customClaims?.["house"])
          .collection("members")
          .doc(loggedUser.uid)
          .collection("points")
          .doc(),
        points,
      );

      await batch.commit();
    }
    return false;
  }
);
