import {getFirestore} from "firebase-admin/firestore";
import * as fs from "fs";
import {Timestamp as timestamp} from "@google-cloud/firestore";

const db = getFirestore();

const collection = 'assignable_points';

const docConverter = {
    toFirestore: (data) => {
        const newData = {...data};
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
    }
};

const getDocs = async () => {
    try {
        const snapshot = await db.collection(collection).withConverter(docConverter).get();
        const docs = snapshot.docs.map(doc => {
            return {
                id: doc.id,
                ...doc.data()
            }
        });
        fs.writeFileSync(`data/read/${collection}.json`, JSON.stringify(docs, null, 2));
    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
}

getDocs().then(r => console.log('Done!'));