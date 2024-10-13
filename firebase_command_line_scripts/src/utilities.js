import admin from 'firebase-admin';
import * as fs from "fs";

export const initFirebaseApp = () => {
    console.info('🚀 Initializing Firebase...');
    const data = fs.readFileSync('./serviceAccountKey.json');
    const serviceAccount = JSON.parse(data);
    console.info('🔑 Service account key loaded');
    if (!admin.apps.length) {
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount)
        });
        console.info('✅  Firebase initialized\n\n');
        return;
    }
    console.info('ℹ️ Firebase already initialized\n\n');
}