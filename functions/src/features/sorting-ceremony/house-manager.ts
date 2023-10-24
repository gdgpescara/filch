import * as functions from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";

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
