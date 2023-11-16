const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const uploadQuests = () => {
    // fs.readFile('data/actor-quiz-quests-a8.json', 'utf8', (err, data) => {
    //     if (err) {
    //         console.error('Error reading the JSON file:', err);
    //         return;
    //     }
    //
    //     // Parse the JSON data
    //     try {
    //         const jsonData = JSON.parse(data);
    //         const batch = db.batch();
    //         for (const quest of jsonData) {
    //             const questRef = db.collection('quests').doc();
    //             batch.create(questRef, {
    //                 ...quest,
    //                 validityStart: timestamp.fromMillis(Date.parse(quest.validityStart)),
    //                 validityEnd: timestamp.fromMillis(Date.parse(quest.validityEnd)),
    //             });
    //         }
    //         batch.commit().then(() => {
    //             console.log('Data successfully written!');
    //         }).catch(err => {
    //             console.error('Error writing data', err);
    //         });
    //     } catch (parseError) {
    //         console.error('Error parsing the JSON data:', parseError);
    //     }
***REMOVED***);

    //get quests and save to json
    db.collection('quests').where('parentQuests', "array-contains-any", [
        "7Ht3teqLm6gVA2ZnjSqK",
        "heNxpIIY7QJ29ACGIU2h",
        "RsqZnSLF2D498DOtbhzF",
        "cjo4I5p2nR22kT8jAeqi"
    ]).get().then((snapshot) => {
        const quests = [];
        snapshot.forEach((doc) => {
            if (doc.data().parentQuests.length > 1) {
                quests.push({
                    id: doc.id,
                    ...doc.data(),
                    validityStart: new Date(doc.data().validityStart._seconds * 1000),
                    validityEnd: new Date(doc.data().validityEnd._seconds * 1000)
                });
            }
        });
        fs.writeFile('data/actor-quiz-a8.json', JSON.stringify(quests), (err) => {
            if (err) throw err;
            console.log('Data written to file');
        });
    }).catch((err) => {
        console.log('Error getting documents', err);
    });
};

uploadQuests();