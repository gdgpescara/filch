import {onRequest} from "firebase-functions/v2/https";
import {getFirestore} from "firebase-admin/firestore";

export const getFadeFromTimeTimestamp = onRequest(
  {region: "europe-west3"},
  async (req, res) => {
    const time = await getFirestore()
      .collection("fade_from_time")
      .doc("latest")
      .get();
    res.status(200).send({timestamp: (await time.get("time"))});
  }
);
