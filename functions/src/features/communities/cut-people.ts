import {onDocumentCreated} from "firebase-functions/v2/firestore";
import {getFirestore} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {logger} from "firebase-functions/v2";
import * as path from "path";
import * as crypto from "crypto";

const fetchAsBlob = async (url:string):Promise<Blob> => fetch(url)
  .then((response) => response.blob());

const convertBlobToBase64 =
  async (blob:Blob):Promise<string> => {
    const buffer = Buffer.from(await blob.arrayBuffer());
    return "data:" + blob.type + ";base64," + buffer.toString("base64");
  };

const convertBase64ToBuffer = (base64:string):Buffer => {
  return Buffer.from(base64, "base64");
};

const md5 = (contents: string) =>
  crypto.createHash("md5").update(contents).digest("hex");

export const cutPeople = onDocumentCreated({
  region: "europe-west3",
  timeoutSeconds: 300,
  memory: "512MiB",
  document: "/community_partner_images/{docId}",
},
async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    logger.info("No data associated with the event");
    return;
  }
  const processed = snapshot.get("processed");
  if (processed == true) {
    logger.info("Document " + event.params.docId +
    " has already been processed");
    return;
  }
  const data = snapshot.data();
  const imageBlob = await fetchAsBlob(data.url);
  const imageBase64 = await convertBlobToBase64(imageBlob);

  const cutRequestBody = {
    img: imageBase64,
  };
  const cutResponse =
    await fetch("https://people-cut-432735089906.europe-west3.run.app/cut", {
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      method: "POST",
      body: JSON.stringify(cutRequestBody),
    });
  const body = await cutResponse.json();

  const metadata = {contentType: "image/png"};
  const bucket = getStorage().bucket("gs://devfestpescara2024.appspot.com");
  const folder = "cut_images";

  for (const encoded of body.data) {
    const md5Name = md5(encoded);
    const filename = md5Name + ".png";
    const imageBuffer = convertBase64ToBuffer(encoded);
    const imagePath = path.join(folder, filename);
    await bucket.file(imagePath).save(imageBuffer, {
      metadata: metadata,
    });
    await getFirestore()
      .collection("cut_images")
      .doc(md5Name)
      .set({
        path: imagePath,
        partner: data.uid,
        status: "created",
      });
  }
  logger.log("Image processed for partner "+data.uid);
});
