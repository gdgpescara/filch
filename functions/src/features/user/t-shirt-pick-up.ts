import {onCall} from "firebase-functions/v2/https";
import {getSignedInUser} from "../../shared/get_signed_in_user";
import {logger} from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";
import {getAuth} from "firebase-admin/auth";

export const tShirtPuckUp = onCall(
  {region: "europe-west3"},
  async (request) => {
    const loggedUser = await getSignedInUser(request);

    logger.info("User: " + JSON.stringify(request.data) +
      " request a t-shirt to: " + loggedUser.uid);

    const userUid = JSON.parse(request.data.user).uid;

    const scannedUser = await getAuth().getUser(userUid);

    if (scannedUser) {
      // get firestore doc and check if already picked up a t-shirt
      const userDoc = await getFirestore()
        .collection("users")
        .doc(scannedUser.uid)
        .get();

      // if already picked up a t-shirt, throw an error
      if (userDoc.data()?.tShirtPickup) {
        throw new Error("User already picked up a t-shirt");
      }

      // set t-shirt pickup flag to true
      await getFirestore()
        .collection("users")
        .doc(scannedUser.uid)
        .update({tShirtPickup: true});

      return true;
    }

    return false;
  });
