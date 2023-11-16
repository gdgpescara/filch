const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const user = "s3BYUUFiwaZjCo3nbT4MJXH5vgw2";

const removeHouse = async () => {
    const users = [];
    try {
        const fetchedUser = await admin.auth().getUser(user);
        // remove house
        const customClaims = fetchedUser.customClaims;
        delete customClaims.house;
        await admin.auth().setCustomUserClaims(user, customClaims);
    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
}

removeHouse();