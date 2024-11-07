import {onRequest} from "firebase-functions/v2/https";
import {getStorage} from "firebase-admin/storage";
import * as path from "path";

export const getFadeFromTime = onRequest(
  {region: "europe-west3"},
  async (req, res) => {
    const bucket = getStorage().bucket("gs://devfestpescara2024.appspot.com");
    const imagePath = path.join("timeline", "actual.png");
    const file = await bucket.file(imagePath).download();
    res.status(200).header("Content-Type", "image/png").send(file[0]);
  }
);
