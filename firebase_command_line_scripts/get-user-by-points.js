const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const {getAuth} = require("firebase-admin/auth");
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const userBypoints = async () => {
    try {
        // get users ordered by points and save those in file
        const users = await db.collection('users').orderBy('points', 'desc').get();
        const usersData = users.docs.map(doc => doc.data());
        fs.writeFileSync('users-by-points.json', JSON.stringify(usersData.map(user => {
            return {
                displayName: user.displayName,
                email: user.email,
                points: user.points,
            }
        })));

        // get members of gopherpuf orderd by points and save in file
        const gopherpufMembers = await db.collection('houses').doc('gopherpuff').collection("members").orderBy('points', 'desc').get();
        const gopherpufMembersData = gopherpufMembers.docs.map(doc => doc.data());
        fs.writeFileSync('gopherpuff-members-by-points.json', JSON.stringify(gopherpufMembersData.map(user => {
            return {
                displayName: user.displayName,
                email: user.email,
                points: user.points,
            }
        })));

    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
};

userBypoints();