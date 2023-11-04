import * as functions from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";
import {getAuth} from "firebase-admin/auth";

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

    // remove user from points collection
    const userPointsSnap = await getFirestore()
      .collection("houses")
      .doc(user.customClaims?.house)
      .collection("members")
      .doc(user.uid)
      .collection("points")
      .get();
    const houseRef = getFirestore()
      .collection("houses")
      .doc(user.customClaims?.house);
    const houseSnap = await houseRef.get();
    const housePoints = houseSnap.data()?.points;
    userPointsSnap.docs.forEach((doc) => {
      batch.update(
        houseRef,
        {points: housePoints - doc.data().points}
      );
      batch.delete(doc.ref);
    });

    // remove user from house members
    batch.delete(
      getFirestore()
        .collection("houses")
        .doc(user.customClaims?.house)
        .collection("members")
        .doc(user.uid)
    );

    await batch.commit();
  });

export const onUserCreateSentinel = functions
  .region("europe-west3")
  .auth
  .user()
  .onCreate(async (user) => {
    // check if nimbus user
    let isNimbusUser = false;
    if (user.displayName) {
      const nimbusUserRef = await getFirestore()
        .collection("nimbus_users")
        .doc(user.displayName)
        .get();
      isNimbusUser = nimbusUserRef.exists;
    }
    await getAuth().setCustomUserClaims(user.uid, {
      isNimbusUser: isNimbusUser,
      ...user.customClaims,
    });

    // add user to users collection
    await getFirestore()
      .collection("users")
      .doc(user.uid)
      .set({
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
        isNimbusUser: isNimbusUser,
        createdAt: user.metadata.creationTime,
      });
  });
