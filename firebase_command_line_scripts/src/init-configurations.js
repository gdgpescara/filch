import * as fs from "fs";
import { initFirebaseApp } from "./utilities.js";
import { getFirestore } from "firebase-admin/firestore";
import { Timestamp as timestamp } from "@google-cloud/firestore";

initFirebaseApp();

const db = getFirestore();

const collection = "configurations";

const dateFields = ["start", "end"];

const docConverter = {
  toFirestore: (data) => {
    const newData = { ...data };
    for (const key in newData) {
      if (dateFields.includes(key)) {
        newData[key] = timestamp.fromDate(new Date(newData[key]));
      }

      if (typeof newData[key] === "object") {
        for (const subKey in newData[key]) {
          if (dateFields.includes(subKey)) {
            newData[key][subKey] = timestamp.fromDate(
              new Date(newData[key][subKey])
            );
          }
        }
      }

      if (Array.isArray(newData[key])) {
        for (const obj of newData[key]) {
          for (const subKey in obj) {
            if (dateFields.includes(subKey)) {
              obj[subKey] = timestamp.fromDate(new Date(obj[subKey]));
            }
          }
        }
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

export const initConfigurations = async () => {
  try {
    const data = fs.readFileSync(`data/configurations.json`);
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

    // assignable points
    const assignablePointsData = fs.readFileSync(`data/assignable_points.json`);
    const assignablePoints = JSON.parse(assignablePointsData);
    for (const point of assignablePoints) {
      const docRef = db.collection("assignable_points").doc(point.id);
      delete point.id;
      batch.set(docRef, point, { merge: true });
    }

    // Teams
    const teamsData = fs.readFileSync(`data/teams.json`);
    const teams = JSON.parse(teamsData);
    for (const team of teams) {
      const docRef = db.collection("teams").doc(team.id);
      delete team.id;
      batch.set(docRef, team, { merge: true });
    }

    await batch.commit();
    console.info(`✅  Successfully uploaded ${collection}`);
  } catch (parseError) {
    console.error("‼️ An error occurred:", parseError);
  }
};
