import * as functions from "firebase-functions/v1";

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

