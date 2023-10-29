import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {getFirestore, Timestamp} from "firebase-admin/firestore";
import {Points} from "./types/points";

export const assignPoints = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);
    const points = <Points>{
      ...request.data.points,
      assignedBy: loggedUser,
      assignedAt: Timestamp.now(),
    };
    const uid = request.data.uid;
    const house = loggedUser.customClaims?.["house"];

    const batch = getFirestore().batch();
    batch.set(
      getFirestore()
        .collection("users")
        .doc(uid)
        .collection("points")
        .doc(),
      points,
    );
    batch.set(
      getFirestore()
        .collection("houses")
        .doc(house)
        .collection("members")
        .doc(uid)
        .collection("points")
        .doc(),
      points,
    );
    await batch.commit();

    return true;
  });
