import * as fs from "fs";
import { createInterface } from "readline";
import { getAuth } from "firebase-admin/auth";
import { getFirestore } from "firebase-admin/firestore";

export const registerSponsorUser = async () => {
  const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  rl.question("Qual'è la mail dell'utente registrato che si vuole promuovere a sponsor? ", async (email) => {
    rl.close();

    if (!email.trim()) {
      console.error("‼️ Email non inserita.");
      return;
    }

    try {
      const fetchedUser = await getAuth().getUserByEmail(email.trim());
      console.info(`✅ Utente trovato: ${fetchedUser.uid} - ${fetchedUser.email}`);

      // Aggiorna custom claims
      const currentClaims = fetchedUser.customClaims || {};
      const newClaims = { ...currentClaims, sponsor: true, team: "mib" };
      await getAuth().setCustomUserClaims(fetchedUser.uid, newClaims);
      console.info(`✅ Custom claims aggiornati per ${fetchedUser.email}`);

      // Aggiorna documento Firestore
      await getFirestore().collection("users").doc(fetchedUser.uid).update({
        sponsor: true,
        team: "mib",
      });
      console.info(`✅ Documento Firestore aggiornato per ${fetchedUser.email}`);

    } catch (error) {
      if (error.code === 'auth/user-not-found') {
        console.error("‼️ Utente non trovato con questa email.");
      } else {
        console.error("‼️ Errore durante la promozione:", error);
      }
    }
  });
};
