import * as functions from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";

export const onUserDeleteSentinel = functions
  .region("europe-west3")
  .auth
  .user()
  .onDelete(async (user) => {
    // remove user from house members
    await getFirestore()
      .collection("houses")
      .doc(user.customClaims?.house)
      .collection("members")
      .doc(user.uid)
      .delete();
  });
