import { onDocumentWritten } from "firebase-functions/v2/firestore";

export const updateHouseMembers = onDocumentWritten(
  {
    document: "houses/{houseId}/members/{memberId}",
    region: "europe-west3",
  },
  async (event) => {
    const membersCount = await event.data?.after?.ref.parent.count().get();
    const houseRef = event.data?.after?.ref.parent.parent;
    if (houseRef && membersCount) {
      await houseRef.update({
        members: membersCount.data().count,
      });
    }
  }
);
