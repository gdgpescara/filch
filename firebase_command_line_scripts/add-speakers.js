const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const speakers = [
  {"email": "lucadivita.ldv@gmail.com", "house": "kerasdor"},
  {"email": "marco.ippolito@nearform.com", "house": "pytherin"},
  {"email": "serradi92@gmail.com", "house": "kerasdor"},
  {"email": "j@fine.dev", "house": "kerasdor"},
  {"email": "denisov.shureg@gmail.com", "house": "dashclaw"},
  {"email": "daniele.favaro.1@gmail.com", "house": "dashclaw"},
  {"email": "g.santomaggio@gmail.com", "house": "gopherpuff"},
  {"email": "carusi.fabio@gmail.com", "house": "kerasdor"},
  {"email": "mkbonfry@gmail.com", "house": "dashclaw"},
  {"email": "matteoterzuolo@gmail.com", "house": "dashclaw"},
  {"email": "bucciarelli.camillo92@gmail.com", "house": "dashclaw"},
  {"email": "enrico@giacomazzi.cc", "house": "gopherpuff"},
  {"email": "a.forese@netsons.com", "house": "gopherpuff"},
  {"email": "paolo@melchiorre.org", "house": "pytherin"},
  {"email": "moreno.mazzocchetti@gmail.com", "house": "pytherin"},
  {"email": "juna.salviati@gmail.com", "house": "pytherin"},
  {"email": "trevisan.federica3@gmail.com", "house": "kerasdor"},
  {"email": "rick.zal239@gmail.com", "house": "gopherpuff"},
  {"email": "ryuujin@athomos.net", "house": "gopherpuff"},
  {"email": "inardini@google.com", "house": "kerasdor"},
  {"email": "stefano.chiccarelli@aesyscyber.com", "house": "gopherpuff"},
  {"email": "villanova.antonio@gmail.com", "house": "dashclaw"},
  {"email": "lorenzadb@gmail.com", "house": "kerasdor"},
  {"email": "giampaolo.fiorentino@frontiere.io", "house": "kerasdor"}
]

const uploadSpeakers = () => {
  try {
    const batch = db.batch();
    for(const speaker of speakers){
        const speakerRef = db.collection('speakers').doc(speaker.email);
        batch.create(speakerRef, {house: speaker.house});
    }
    batch.commit().then(() => {
        console.log('Data successfully written!');
    }).catch(err => {
        console.error('Error writing data', err);
    });
  } catch (parseError) {
    console.error('Error parsing the JSON data:', parseError);
  }
};

uploadSpeakers();