const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
const fs = require('fs');
const timestamp = admin.firestore.Timestamp;

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const staff = [
    {
        email: "simone.dinardo.dimaio@staff.it",
        nome: "Simone Di Nardo Di Maio",
        password: "AbCdEfGh"
    },
    {
        email: "alessandro.iacobucci@staff.it",
        nome: "Alessandro Iacobucci",
        password: "IjKlMnOp"
    },
    {
        email: "antonio.villanova@staff.it",
        nome: "Antonio Villanova",
        password: "QrStUvWx"
    },
    {
        email: "simone.pellegrini@staff.it",
        nome: "Simone Pellegrini",
        password: "Yz123456"
    },
    {
        email: "martina.irsuti@staff.it",
        nome: "Martina Irsuti",
        password: "789AbCd"
    },
    {
        email: "luca.divita@staff.it",
        nome: "Luca Di Vita",
        password: "EfGhIjKl"
    },
    {
        email: "claudia.daddiego@staff.it",
        nome: "Claudia D'Addiego",
        password: "MnOpQrSt"
    },
    {
        email: "alessio.padula@staff.it",
        nome: "Alessio Padula",
        password: "UvWxYz12"
    },
    {
        email: "paolo.melchiorre@staff.it",
        nome: "Paolo Melchiorre",
        password: "34567890"
    },
    {
        email: "biagio.decataldo@staff.it",
        nome: "Biagio Decataldo",
        password: "AbCdEfGh"
    },
    {
        email: "nicola.palmieri@staff.it",
        nome: "Nicola Palmieri",
        password: "IjKlMnOp"
    },
    {
        email: "gianni.forlastro@staff.it",
        nome: "Gianni Forlastro",
        password: "QrStUvWx"
    },
    {
        email: "giorgio.campea@staff.it",
        nome: "Giorgio Campea",
        password: "Yz123456"
    },
    {
        email: "francesco.pirrone@staff.it",
        nome: "Francesco Pirrone",
        password: "789AbCd"
    },
    {
        email: "maikol.orlandi@staff.it",
        nome: "Maikol Orlandi",
        password: "EfGhIjKl"
    },
    {
        email: "enzo.carolla@staff.it",
        nome: "Enzo Carolla",
        password: "MnOpQrSt"
    },
    {
        email: "antonio.passarella@staff.it",
        nome: "Antonio Passarella",
        password: "UvWxYz12"
    },
    {
        email: "rosa.taormina@staff.it",
        nome: "Rosa Taormina",
        password: "34567890"
    },
    {
        email: "andreas.polidoro@staff.it",
        nome: "Andreas Polidoro",
        password: "AbCdEfGh"
    },
    {
        email: "giorgia.diplacido@staff.it",
        nome: "Giorgia Di Placido",
        password: "IjKlMnOp"
    },
    {
        email: "michela.bertaina@staff.it",
        nome: "Michela Bertaina",
        password: "QrStUvWx"
    },
    {
        email: "antonio.dimarino@staff.it",
        nome: "Antonio Di Marino",
        password: "Yz123456"
    },
    {
        email: "pamela.contini@staff.it",
        nome: "Pamela Contini",
        password: "789AbCd"
    },
    {
        email: "gregorio.palama@staff.it",
        nome: "Gregorio Palamà",
        password: "EfGhIjKl"
    },
    {
        email: "giada.costantini@staff.it",
        nome: "Giada Costantini",
        password: "MnOpQrSt"
    },
    {
        email: "alessio.valentini@staff.it",
        nome: "Alessio Valentini",
        password: "UvWxYz12"
    },
    {
        email: "camillo.bucciarelli@staff.it",
        nome: "Camillo Bucciarelli",
        password: "34567890"
    },
    {
        email: "paola.dignazio@staff.it",
        nome: "Paola D'Ignazio",
        password: "AbCdEfGh"
    },
    {
        email: "severus.python@actor.it",
        nome: "Severus Python",
        password: "IjKlMnOp"
    },
    {
        email: "filius.dartous@actor.it",
        nome: "Filius Dartous",
        password: "QrStUvWx"
    },
    {
        email: "sibilla.goman@actor.it",
        nome: "Sibilla Goman",
        password: "Yz123456"
    },
    {
        email: "silvanus.kerasburn@actor.it",
        nome: "Silvanus Kerasburn",
        password: "789AbCd"
    },
];


const createAccounts = async () => {
    const users = [];
    try {
        for (const user of staff) {
            let fetchedUser;
            try {
                fetchedUser = await admin.auth().getUserByEmail(user.email);
            } catch (error) {
            }
            if (!fetchedUser) {
                const createdUser = await admin.auth().createUser({
                    email: user.email,
                    displayName: user.nome,
                    password: user.password,
                    emailVerified: true
                });
                fetchedUser = createdUser;
                console.log(`Successfully created user ${createdUser.uid} with email ${createdUser.email}`);
            } else {
                console.log(`User ${fetchedUser.email} already exists`);
            }
            const data = {
                uid: fetchedUser.uid,
                email: fetchedUser.email,
                displayName: fetchedUser.displayName,
                password: user.password
            }
            users.push(data);
            fs.writeFileSync('data/staff.json', JSON.stringify(users));
        }
    } catch (parseError) {
        console.error('Error parsing the JSON data:', parseError);
    }
}

createAccounts();