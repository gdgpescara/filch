import {onSchedule} from "firebase-functions/v2/scheduler";
import {getFirestore} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {logger} from "firebase-functions";
import * as sharp from "sharp";
import * as path from "path";

let compositingImagesHeight = 1250;
const compositingGap = 20;
const partnersInteractionsLimit = 2;

export const fadeFromTime = onSchedule({
  schedule: "every 5 minutes",
  timeZone: "Europe/Rome",
  region: "europe-west3",
  timeoutSeconds: 1200,
  memory: "1GiB",
}, async () => {
  const timelinesSnapshot = await getFirestore()
    .collection("timelines")
    .orderBy("count", "desc")
    .limit(1)
    .get();

  if (timelinesSnapshot.size != 1) {
    logger.error("Got too many timelines");
    return;
  }

  const bucket = getStorage().bucket("gs://devfestpescara2024.appspot.com");

  const timelineId = timelinesSnapshot.docs.at(0)?.id;
  const timelinesBackgroundFolder = "backgrounds";
  const timelineFilename = timelineId + ".jpg";
  const timelinePath = path.join(timelinesBackgroundFolder, timelineFilename);
  const timelineResponse = await bucket.file(timelinePath).download();
  const timeline = sharp(timelineResponse[0]);

  const partnerSnapshot = await getFirestore()
    .collection("partners_interactions")
    .orderBy("count", "desc")
    .limit(partnersInteractionsLimit)
    .get();

  const partnerIds = [];
  for (const partner of partnerSnapshot.docs) {
    partnerIds.push(partner.id);
    logger.info("adding partner " + partner.id);
  }
  const picsSnapshot = await getFirestore()
    .collection("cut_images")
    .where("status", "==", "detected")
    .where("partner", "in", partnerIds)
    .where("joy", "==", "VERY_LIKELY")
    .orderBy("count", "asc")
    .get();
  logger.info("read " + picsSnapshot.size + " pics");
  const timelineMetadata = await timeline.metadata();
  if (timelineMetadata.height == undefined ||
    timelineMetadata.width == undefined) {
    logger.error("Timeline height or width is undefined");
    return;
  }
  let leftOffset = compositingGap;
  const compositeImages = [];
  for (const picDoc of picsSnapshot.docs) {
    let picCount = 0;
    const picData = picDoc.data();
    const picResponse = await bucket.file(picData.path).download();
    let pic = sharp(picResponse[0]);
    if (timelineId == "1885") {
      pic.tint({r: 227, g: 206, b: 185});
    }
    if (timelineId == "1955") {
      pic.greyscale();
      compositingImagesHeight = 1400;
    }
    if (timelineId == "1985") {
      compositingImagesHeight = 1500;
    }
    pic = await pic.resize({height: compositingImagesHeight});
    const picMetadata = await pic.metadata();
    if (picMetadata.width == undefined || picMetadata.height == undefined) {
      logger.info("an image does not have width or height");
      continue;
    }

    const resizedWidth = Math.round((compositingImagesHeight *
      picMetadata.width) / picMetadata.height);
    logger.info("image sizes: " + picMetadata.width + "x" +
      picMetadata.height);
    logger.info("image has a width of " + resizedWidth);
    if ((leftOffset + resizedWidth) > timelineMetadata.width) {
      break;
    }
    compositeImages.push({
      input: await pic.toBuffer(),
      top: timelineMetadata.height - compositingImagesHeight,
      left: leftOffset,
    });
    if (picDoc.get("count") != null && picDoc.get("count") != undefined) {
      picCount = picDoc.data()?.count + 1;
    }
    picDoc.ref.update({
      count: picCount,
    });
    leftOffset = leftOffset + resizedWidth + compositingGap;
    logger.info("image added, new offset is " + leftOffset);
  }
  timeline.composite(compositeImages);

  const imagePath = path.join("timeline", "actual.png");
  const metadata = {contentType: "image/png"};
  await bucket.file(imagePath).save(await timeline.toBuffer(), {
    metadata: metadata,
  });
  await getFirestore()
    .collection("fade_from_time")
    .doc("latest")
    .set({
      time: Date.now(),
    });

  logger.info("Correctly handled");
});
