import * as functions from "firebase-functions";

export const updateHouseMembers = functions
  .region("europe-west3")
  .firestore
  .document("houses/{houseId}/members/{memberId}")
  .onWrite(async (change) => {
    const membersCount = await change.after.ref.parent.count().get();
    const houseRef = change.after.ref.parent.parent;
    if (houseRef) {
      await houseRef.update({
        members: membersCount.data().count,
      });
    }
  });
