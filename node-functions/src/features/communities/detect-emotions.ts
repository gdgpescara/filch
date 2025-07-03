import {onDocumentCreated} from "firebase-functions/v2/firestore";
import {getFirestore} from "firebase-admin/firestore";
import {logger} from "firebase-functions/v2";
import * as vision from "@google-cloud/vision";

export const detectEmotions = onDocumentCreated({
  region: "europe-west3",
  timeoutSeconds: 300,
  document: "/cut_images/{docId}",
},
async (event) => {
  const snapshot = event.data;
  if (!snapshot) {
    logger.info("No data associated with the event");
    return;
  }
  const data = snapshot.data();
  if (data.status != "created") {
    logger.error("Document " + event.params.docId +
    " has inconsistent status");
    return;
  }

  const client = new vision.ImageAnnotatorClient();
  const [result] = await client.faceDetection(`gs://devfestpescara2024.appspot.com/${data.path}`);
  const faces = result.faceAnnotations;

  if (faces == null || faces == undefined) {
    logger.error("Image for " + event.params.docId +
      " has no faces");
    return;
  }

  if (faces?.length > 1) {
    logger.error("Image for " + event.params.docId +
    " has multiple faces");
    return;
  }

  const face = faces[0];
  await getFirestore()
    .collection("cut_images")
    .doc(event.params.docId)
    .update({
      status: "detected",
      joy: face.joyLikelihood,
      anger: face.angerLikelihood,
      sorrow: face.sorrowLikelihood,
      surprise: face.surpriseLikelihood,
    });
  logger.info("Face for " + event.params.docId +
      " has been detected");
});
