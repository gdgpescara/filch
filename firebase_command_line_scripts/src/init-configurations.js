import * as fs from 'fs';
import {initFirebaseApp} from './utilities.js';
import {getFirestore} from "firebase-admin/firestore";

initFirebaseApp();

const db = getFirestore();

const collection = 'configurations';

export const initConfigurations = async () => {
    try {
        const data = fs.readFileSync(`data/configurations.json`);
        const docs = JSON.parse(data);
        const batch = db.batch();
        docs.forEach(doc => {
            const docRef = db.collection(collection).doc(doc.id);
            delete doc.id;
            batch.set(docRef, doc, {merge: true});
        });
        await batch.commit();
        console.info(`✅  Successfully uploaded ${collection}`);
    } catch (parseError) {
        console.error('‼️ An error occurred:', parseError);
    }
}
