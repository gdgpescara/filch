import {getAuth} from "firebase-admin/auth";
import {logger} from "firebase-functions/v2";
import {getFirestore} from "firebase-admin/firestore";
import {sortingHatAlgorithm} from "./sorting-hat-algorithm";
import {HttpsError, onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";

export const sortingCeremony = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

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
      .doc(loggedUser.uid)
      .set({
        email: loggedUser.email,
      });

    await getAuth().setCustomUserClaims(loggedUser.uid, {
      house: house.id,
    });

    logger.info("Assigned house", house.id, "to user", loggedUser.email);

    return house.id;
  });
