const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const nimbusUsers = [
    "Alain D'Ettorre",
    "Alba Ruiz Gutiérrez",
    "Alessandro Pace",
    "Alessandro Scioli",
    "Alessandro Taricani",
    "Andy Andrei",
    "Angelo Sebastiano",
    "Camillo Bucciarelli",
    "Carlo Lucera",
    "Creepy Smiling Carl",
    "Daniela Bonvini",
    "Daniele Irsuti",
    "Davide Fella",
    "Davide Gallotti",
    "Emanuele Gurini",
    "Eugenia Zazzetta",
    "Fabio Cabras",
    "Fabio Carusi",
    "Fabio Alfineo di Gabriele",
    "Felice Morea",
    "Filippo Santurbano",
    "Francesco Di Sciascio",
    "Francesco Fiorè",
    "Gabriele Serafini",
    "Giampaolo Di Giulio",
    "Gianni Forlastro",
    "Giorgio Campea",
    "Giovanna Radica",
    "Grazia Quercia",
    "Ivan Nardini",
    "Kiara Fiorella Abad Bruzzo",
    "Lorenza De Berardinis",
    "Lorenzo De Francesco",
    "Lucio Di Matteo",
    "Luigi Brandolini",
    "Majk Mone",
    "Marco Biasone",
    "Maria Burtan",
    "Mariagiovanna Rotundo",
    "Massimiliano D'Angelo",
    "Michalina Kami≈Ñska",
    "Michele Palma",
    "Mladen Lazoviƒá",
    "Nicola Palmieri",
    "Riccardo Italiani",
    "Simone Pellegrini",
    "Stefano Petrini",
    "Vincenzo Lombardi",
    "Vincenzo Petrucci",
    "Vittorio Arcari"
];

const uploadNimbus = () => {
    try {
        const batch = db.batch();
        for (const nimbusUser of nimbusUsers) {
            const nimbusRef = db.collection('nimbus_users').doc(nimbusUser);
            batch.create(nimbusRef, {});
        }
        batch.commit().then(() => {
            console.log('Data successfully written!');
        }).catch(err => {
            console.error('Error writing data', err);
        });
    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
}

uploadNimbus();