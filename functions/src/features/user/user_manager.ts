import * as functions from "firebase-functions/v1";
import {getFirestore} from "firebase-admin/firestore";

export const onUserDeleteSentinel = functions
  .region("europe-west3")
  .auth
  .user()
  .onDelete(async (user) => {
    const batch = getFirestore().batch();
    // remove user from users collection
    batch.delete(
      getFirestore()
        .collection("users")
        .doc(user.uid)
    );
    await batch.commit();
  });

export const onUserCreateSentinel = functions
  .region("europe-west3")
  .auth
  .user()
  .onCreate(async (user) => {
    // add user to users collection
    await getFirestore()
      .collection("users")
      .doc(user.uid)
      .set({
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
        createdAt: user.metadata.creationTime,
        tShirtPickup: false,
        points: 0,
      });
  });
