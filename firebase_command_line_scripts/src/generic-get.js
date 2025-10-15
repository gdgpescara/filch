import { getFirestore } from "firebase-admin/firestore";
import * as fs from "fs";
import { Timestamp as timestamp } from "@google-cloud/firestore";
import { initFirebaseApp } from "./utilities.js";

initFirebaseApp();

const db = getFirestore();

const collection = "quests";

const docConverter = {
  toFirestore: (data) => {
    const newData = { ...data };
    for (const key in newData) {
      if (newData[key] instanceof Date) {
        newData[key] = timestamp.fromDate(newData[key]);
      }
    }
    return newData;
  },
  fromFirestore: (snapshot, options) => {
    const data = snapshot.data(options);
    for (const key in data) {
      if (data[key] instanceof timestamp) {
        data[key] = data[key].toDate();
      }
    }
    return data;
  },
};

const getDocs = async () => {
  try {
    const usersSnap = await db
      .collection("users")
      .where("staff", "!=", true)
      .get();

    const users = [];

    for (const snapshot of usersSnap.docs) {
      const pointsSnap = await db
        .collection("users")
        .doc(snapshot.id)
        .collection("points")
        .withConverter(docConverter)
        .where("assignedBy", "==", "5pxMUJxU40RQxI4RBqDpe6hGDyu2")
        .get();
      if (pointsSnap.empty) {
        continue;
      }
      users.push({
        email: snapshot.get("email"),
        displayName: snapshot.get("displayName"),
        points: pointsSnap.docs.map((doc) => {
          return {
            id: doc.id,
            ...doc.data(),
          };
        }),
      });
    }
    fs.writeFileSync(
      `data/read/pythonPescara.json`,
      JSON.stringify(users, null, 2)
    );
  } catch (parseError) {
    console.error("Error parsing the JSON data:", parseError);
  }
};

getDocs().then((r) => console.log("Done!"));
