const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const cleanDirtyPoints = async () => {
    try {
        // get members points from firestore and round to int
        const batch = db.batch();
        // const houses = await db.collection('houses').get();
        // for(const house of houses.docs) {
        //
        //     const members = await db.collection('houses').doc(house.id).collection('members').get();
        //     for(const member of members.docs) {
        //         batch.update(db.collection('houses').doc(house.id).collection('members').doc(member.id), {
        //             points: Math.floor(member.data().points)
        //         });
        //     }
    ***REMOVED***
        const users = await db.collection('users').get();
        for(const user of users.docs) {
            const points = await db.collection('users').doc(user.id).collection('points').get();
            for(const point of points.docs) {
                batch.update(db.collection('users').doc(user.id).collection('points').doc(point.id), {
                    points: Math.floor(point.data().points)
                });
            }
        }

        await batch.commit();
    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
};

cleanDirtyPoints();