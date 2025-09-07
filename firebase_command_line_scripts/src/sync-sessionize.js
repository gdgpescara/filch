import admin from "firebase-admin";
import { initFirebaseApp } from "./utilities.js";
import * as fs from "fs";
import { GoogleAuth } from "google-auth-library";

// Imposta la variabile d'ambiente per ignorare i certificati SSL
process.env["NODE_TLS_REJECT_UNAUTHORIZED"] = "0";

/**
 * Funzione per leggere la configurazione dal file sessionize.json
 */
const getSessionizeConfig = () => {
  try {
    const data = fs.readFileSync("./data/sessionize.json", "utf8");
    const sessionizeData = JSON.parse(data);
    return {
      eventId: sessionizeData.eventId,
      fetchUrl: sessionizeData.endpoints.fetchUrl,
    };
  } catch (error) {
    console.error("❌ Errore nella lettura del file sessionize.json:", error);
    throw error;
  }
};

/**
 * Funzione per ottenere un Identity Token per Cloud Run
 */
const getCloudRunIdentityToken = async (targetUrl) => {
  try {
    const auth = new GoogleAuth({
      keyFilename: './serviceAccountKey.json'
    });
    
    // Ottieni un Identity Token per l'URL specifico di Cloud Run
    const client = await auth.getIdTokenClient(targetUrl);
    const idToken = await client.idTokenProvider.fetchIdToken(targetUrl);
    
    console.log(`✅ Identity Token generato per Cloud Run: ${targetUrl}`);
    return idToken;
  } catch (error) {
    console.error(`❌ Errore nella generazione dell'Identity Token per ${targetUrl}:`, error);
    throw error;
  }
};

/**
 * Funzione per testare la connettività degli endpoint
 */
const testEndpointConnectivity = async (url, identityToken) => {
  try {
    console.log(`🔍 Testing endpoint: ${url}...`);

    // Test con richiesta base senza parametri
    const response = await fetch(url, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${identityToken}`,
      },
    });

    console.log(`📋 Status: ${response.status}`);
    console.log(`📋 Headers:`, Object.fromEntries(response.headers.entries()));

    const responseText = await response.text();
    console.log(`📋 Response:`, responseText);

    return { status: response.status, text: responseText };
  } catch (error) {
    console.error(`❌ Errore nel test di ${url}:`, error);
    return { error: error.message };
  }
};

/**
 * Fallback: Funzione per chiamare un endpoint Cloud Run con POST
 */
const callCloudRunEndpointPOST = async (url, payload, identityToken) => {
  try {
    console.log(`🌐 Chiamando Cloud Run endpoint (POST): ${url}...`);

    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${identityToken}`,
      },
      body: JSON.stringify(payload),
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.log(`❌ Errore ${response.status} da ${url}:`, errorText);
      throw new Error(`HTTP error! status: ${response.status} - ${errorText}`);
    }

    const result = await response.json();
    console.log(`✅ Risposta da ${url}:`, result);
    return result;
  } catch (error) {
    console.error(`❌ Errore nella chiamata a ${url}:`, error);
    throw error;
  }
};

/**
 * Funzione principale per sincronizzare i dati da Sessionize
 */
export const syncSessionizeData = async () => {
  try {
    console.log("🔄 Avvio sincronizzazione dati Sessionize...\n");

    // Inizializza Firebase Admin SDK
    initFirebaseApp();

    // Leggi configurazione dal file sessionize.json
    console.log("📂 Lettura configurazione dal file sessionize.json...");
    const config = getSessionizeConfig();

    if (!config.eventId || config.eventId.trim() === "") {
      console.log(
        "❌ Event ID non trovato o non valido nel file sessionize.json"
      );
      return;
    }

    console.log(`📋 Event ID: ${config.eventId}`);
    console.log(`📋 Fetch URL: ${config.fetchUrl}\n`);

    // Ottieni Identity Token per l'endpoint Cloud Run
    console.log("🔐 Generazione Identity Token per Cloud Run endpoint...");
    const identityToken = await getCloudRunIdentityToken(config.fetchUrl);

    // Payload da inviare
    const payload = { event_id: config.eventId };

    console.log("\n");

    // Chiama l'endpoint unificato per sincronizzare tutti i dati
    console.log("🌐 Chiamando endpoint per sincronizzazione completa...");
    let result;
    try {
      result = await callCloudRunEndpointPOST(
        config.fetchUrl,
        payload,
        identityToken
      );
      console.log("✅ Sincronizzazione completata con successo!");
    } catch (error) {
      console.error("❌ Errore durante la sincronizzazione:", error.message);
      result = { error: error.message };
    }

    console.log("\n🎉 Sincronizzazione completata!");
    console.log("📊 Risultati:", result);
  } catch (error) {
    console.error("❌ Errore durante la sincronizzazione:", error);
  }
};

// Se il file viene eseguito direttamente
if (import.meta.url === `file://${process.argv[1]}`) {
  syncSessionizeData();
}