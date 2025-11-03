import { getFirestore, Timestamp } from "firebase-admin/firestore";
import * as fs from "fs";

const db = getFirestore();

const collection = "quests";
const dateFields = ["validityStart", "validityEnd"];

const docConverter= {
  toFirestore: (data) => {
    const newData = { ...data };
    for (const key in newData) {
      if (dateFields.includes(key)) {
        newData[key] = Timestamp.fromDate(new Date(newData[key]));
      }
    }
    return newData;
  },
  fromFirestore: (snapshot, options) => {
    const data = snapshot.data(options);
    for (const key in data) {
      if (data[key] instanceof Timestamp) {
        data[key] = data[key].toDate();
      }
    }
    return data;
  },
};

export const updateQuests = async () => {
  try {
    const questsFiles = fs.readdirSync(`data/quests`);
    for (const file of questsFiles) {
      const data = fs.readFileSync(`data/quests/${file}`);
      const docs = JSON.parse(data);
      const batch = db.batch();
      docs.forEach((doc) => {
        const docRef = db
          .collection(collection)
          .withConverter(docConverter)
          .doc(doc.id);
        delete doc.id;
        batch.set(docRef, doc, { merge: true });
      });
      await batch.commit();
      console.info(`✅  Successfully uploaded ${file}`);
    }
  } catch (parseError) {
    console.error("‼️ An error occurred:", parseError);
  }
};
