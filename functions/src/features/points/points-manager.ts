import * as functions from "firebase-functions";

export const userPointsSentinel = functions
  .region("europe-west3")
  .firestore
  .document("users/{uid}/points/{archivedPointsId}")
  .onWrite(async (change) => {
    const previousPoints = change.before.data()?.points ?? 0;
    const points = change.after.data()?.points ?? 0;
    if (previousPoints !== points) {
      const userRef = change.after.ref.parent.parent;
      if (userRef) {
        const userSnap = await userRef.get();
        const user = userSnap.data();
        await userRef.update({
          points: (user?.points ?? 0) - previousPoints + points,
        });
      }
    }
  });

export const memberPointsSentinel = functions
  .region("europe-west3")
  .firestore
  .document("houses/{houseId}/members/{uid}/points/{archivedPointsId}")
  .onWrite(async (change) => {
    const previousPoints = change.before.data()?.points ?? 0;
    const points = change.after.data()?.points ?? 0;
    if (previousPoints !== points) {
      const memberRef = change.after.ref.parent.parent;
      if (memberRef) {
        const memberSnap = await memberRef.get();
        const member = memberSnap.data();
        await memberRef.update({
          points: (member?.points ?? 0) - previousPoints + points,
        });
      }
      const houseRef = change.after.ref.parent.parent?.parent.parent;
      if (houseRef) {
        const houseSnap = await houseRef.get();
        const house = houseSnap.data();
        await houseRef.update({
          points: (house?.points ?? 0) - previousPoints + points,
        });
      }
    }
  });

