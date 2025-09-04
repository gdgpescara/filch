# Configurazione Variabili d'Ambiente

Per configurare l'applicazione in diversi ambienti (sviluppo, test, produzione), segui queste istruzioni:

## Sviluppo Locale

1. Crea o modifica il file `.env` nella cartella `functions/`:
   ```
   FIREBASE_REGION=europe-west3
   # Aggiungi altre variabili d'ambiente come necessario
   ```

2. Le variabili verranno caricate automaticamente all'avvio dell'applicazione.

## Ambiente di Produzione (Firebase)

Per configurare le variabili d'ambiente in produzione, usa il comando Firebase CLI:

```bash
firebase functions:config:set region.firebase="europe-west3"
```

Per visualizzare la configurazione attuale:

```bash
firebase functions:config:get
```

## Recupero Variabili in Funzioni Cloud

Le variabili d'ambiente vengono caricate automaticamente all'avvio e possono essere utilizzate in tutto il codice attraverso il modulo `shared/env.py`.

Esempio:
```python
from shared.env import FIREBASE_REGION

# Usa FIREBASE_REGION nelle tue funzioni
```

## Aggiungere Nuove Variabili d'Ambiente

1. Aggiungi la variabile nel file `.env` per l'ambiente locale
2. Aggiungi la variabile nel modulo `shared/env.py`:
   ```python
   NUOVA_VARIABILE = os.environ.get("NUOVA_VARIABILE", "valore_default")
   ```
3. Per l'ambiente di produzione, configura usando Firebase CLI:
   ```bash
   firebase functions:config:set nuova.variabile="valore"
   ```
