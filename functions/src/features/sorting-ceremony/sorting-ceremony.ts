import {getAuth} from "firebase-admin/auth";
import {logger} from "firebase-functions/v2";
import {getFirestore} from "firebase-admin/firestore";
import {sortingHatAlgorithm} from "./sorting-hat-algorithm";
import {HttpsError, onCall} from "firebase-functions/v2/https";
import * as functions from "firebase-functions";

export const sortingCeremony = onCall(
  {region: "europe-west3"},
  async (request) => {
    const uid = request.auth?.uid;

    if (!uid) {
      logger.error("User is not logged in");
      throw new HttpsError("unauthenticated", "User is not logged in");
    }

    const loggedUser = await getAuth().getUser(uid);

    if (loggedUser.customClaims?.house) {
      logger.error("User already has a house");
      throw new HttpsError("already-exists", "User already has a house");
    }

    const housesSnapshot = await getFirestore()
      .collection("houses")
      .get();

    const house = sortingHatAlgorithm(housesSnapshot.docs);

    await getFirestore()
      .collection("houses")
      .doc(house.id)
      .collection("members")
      .doc(uid)
      .set({
        email: loggedUser.email,
      });

    await getAuth().setCustomUserClaims(uid, {
      house: house.id,
    });

    logger.info("Assigned house", house.id, "to user", loggedUser.email);

    return house.id;
  });

export const updateHouseMembers = functions
  .region("europe-west3")
  .firestore
  .document("houses/{houseId}/members/{memberId}")
  .onWrite(async (change, context) => {
    const houseId = context.params.houseId;
    const membersCount = await change.after.ref.parent.count().get();

    await getFirestore()
      .collection("houses")
      .doc(houseId)
      .update({
        members: membersCount.data().count,
      });
  });
