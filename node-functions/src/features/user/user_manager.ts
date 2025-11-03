import * as functions from "firebase-functions/v1";
import {getFirestore} from "firebase-admin/firestore";

export const onUserDeleteSentinel = functions
  .region("europe-west3")
  .auth
  .user()
  .onDelete(async (user) => {
    const batch = getFirestore().batch();

    //remove user subcollections
    const userCollections = await getFirestore()
      .collection("users")
      .doc(user.uid)
      .listCollections();
    for (const collection of userCollections) {
      const docsSnapshot = await collection.get();
      docsSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });
    }


    // remove user from users collection 
    batch.delete(
      getFirestore()
        .collection("users")
        .doc(user.uid)
    );

    // remove user from members subcollection in teams
    const teamMembersSnapshot = await getFirestore()
      .collectionGroup("members")
      .where("uid", "==", user.uid)
      .get();
    teamMembersSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });

    // commit batch
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
        staff: false,
        sponsor: false,
        tShirtPickup: false,
        tShirtPickupRequested: false,
        fcmToken: null,
        points: 0,
      });
  });
