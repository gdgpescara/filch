import { createInterface } from "readline";
import { getAuth } from "firebase-admin/auth";
import { getFirestore } from "firebase-admin/firestore";

const promoteUserToStaff = async (email) => {
  try {
    const fetchedUser = await getAuth().getUserByEmail(email.trim());
    console.info(`✅ Utente trovato: ${fetchedUser.uid} - ${fetchedUser.email}`);

    // Aggiorna custom claims
    const currentClaims = fetchedUser.customClaims || {};
    const newClaims = { ...currentClaims, staff: true, team: "mib" };
    await getAuth().setCustomUserClaims(fetchedUser.uid, newClaims);
    console.info(`✅ Custom claims aggiornati per ${fetchedUser.email}`);

    // Aggiorna documento Firestore
    await getFirestore().collection("users").doc(fetchedUser.uid).update({
      staff: true,
      team: "mib",
    });
    console.info(`✅ Documento Firestore aggiornato per ${fetchedUser.email}`);
    return { success: true, email: fetchedUser.email };

  } catch (error) {
    if (error.code === 'auth/user-not-found') {
      console.error(`‼️ Utente non trovato con questa email: ${email}`);
      return { success: false, email, error: 'Utente non trovato' };
    } else {
      console.error(`‼️ Errore durante la promozione di ${email}:`, error);
      return { success: false, email, error: error.message };
    }
  }
};

export const registerStaffUser = async () => {
  const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  rl.question("Inserisci le email degli utenti da promuovere a staff (separate da virgola o punto e virgola): ", async (input) => {
    rl.close();

    if (!input.trim()) {
      console.error("‼️ Nessuna email inserita.");
      return;
    }

    // Separa le email per virgola o punto e virgola e rimuove spazi
    const emails = input.split(/[,;]/).map(email => email.trim()).filter(email => email);

    if (emails.length === 0) {
      console.error("‼️ Nessuna email valida trovata.");
      return;
    }

    console.info(`\n📧 Trovate ${emails.length} email da processare\n`);

    const results = [];
    for (const email of emails) {
      console.info(`\n--- Processando: ${email} ---`);
      const result = await promoteUserToStaff(email);
      results.push(result);
    }

    // Riepilogo finale
    console.info("\n\n========== RIEPILOGO ==========");
    const successful = results.filter(r => r.success);
    const failed = results.filter(r => !r.success);

    console.info(`✅ Promossi con successo: ${successful.length}/${results.length}`);
    if (successful.length > 0) {
      successful.forEach(r => console.info(`   - ${r.email}`));
    }

    if (failed.length > 0) {
      console.error(`\n❌ Falliti: ${failed.length}/${results.length}`);
      failed.forEach(r => console.error(`   - ${r.email}: ${r.error}`));
    }
  });
};
