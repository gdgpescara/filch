const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const uploadShift = () => {
  fs.readFile('data/shifts.json', 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading the JSON file:', err);
    return;
  }

  // Parse the JSON data
  try {
    const jsonData = JSON.parse(data);
    const batch = db.batch();
    for(const shift of jsonData){
        const shiftRef = db.collection('shifts').doc();
        batch.create(shiftRef, {...shift, start: timestamp.fromMillis(Date.parse(shift.start))});
    }
    batch.commit().then(() => {
        console.log('Data successfully written!');
    }).catch(err => {
        console.error('Error writing data', err);
    });
  } catch (parseError) {
    console.error('Error parsing the JSON data:', parseError);
  }
});

};

uploadShift();