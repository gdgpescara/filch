# Sorting Ceremony

Questo modulo gestisce il processo di "Sorting Ceremony" (Cerimonia di Smistamento) all'interno dell'applicazione Filch. La cerimonia assegna un utente a una delle quattro casate disponibili (Pytherin, Kerasdor, Dashclaw o Gopherpuff) basate su tecnologie di programmazione diverse.

## Panoramica del Flusso

Il flusso della cerimonia di smistamento funziona nel seguente modo:

1. Un utente si registra/accede all'applicazione
2. Il sistema verifica se l'utente necessita della cerimonia di smistamento
3. Se necessario, viene mostrata l'interfaccia di smistamento
4. L'utente avvia la cerimonia
5. Una chiamata a una funzione Cloud viene effettuata
6. La funzione assegna una casata all'utente
7. Il risultato viene visualizzato all'utente
8. I dati dell'utente vengono aggiornati su Firebase Authentication (custom claims)

## Requisiti Database (Firestore)

### Struttura Database

La cerimonia di smistamento non richiede una struttura specifica di Firestore per funzionare, ma si basa principalmente sui custom claims di Firebase Authentication. Tuttavia, il sistema può utilizzare le seguenti collezioni:

- **users**: Collezione che contiene documenti per ogni utente
  - `uid`: ID dell'utente (corrispondente all'ID di Firebase Auth)
  - `team`: La casata assegnata all'utente (pytherin, kerasdor, dashclaw, gopherpuff)
  - `team_assignment_date`: Timestamp di quando è avvenuta l'assegnazione

### Indici

Non sono necessari indici specifici per il funzionamento base della cerimonia di smistamento.

## Firebase Functions

La cerimonia di smistamento utilizza Firebase Functions per l'assegnazione delle casate. La funzione principale richiede:

### Funzioni Cloud richieste

La funzione principale che deve essere implementata è:

```python
# Nome suggerito per la funzione: assign_team
@https_fn.on_call()
def assign_team(req: https_fn.CallableRequest) -> str:
    # 1. Verifica che l'utente sia autenticato
    if not req.auth:
        raise https_fn.HttpsError("unauthenticated", "L'utente deve essere autenticato")
        
    uid = req.auth.uid
    
    # 2. Verifica che l'utente non abbia già una casata assegnata
    # Recupera i custom claims dell'utente
    user = auth.get_user(uid)
    if user.custom_claims and 'team' in user.custom_claims:
        raise https_fn.HttpsError("already-exists", "L'utente ha già una casata assegnata")
    
    # 3. Logica di assegnazione casata (può essere casuale o basata su criteri specifici)
    houses = ["pytherin", "kerasdor", "dashclaw", "gopherpuff"]
    # Implementa logica di selezione (esempio: scelta casuale)
    import random
    assigned_house = random.choice(houses)
    
    # 4. Aggiorna i custom claims dell'utente con la casata assegnata
    auth.set_custom_user_claims(uid, {
        'team': assigned_house
    })
    
    # 5. Opzionale: Salva l'info nel documento dell'utente su Firestore
    db = firestore.client()
    db.collection('users').document(uid).set({
        'team': assigned_house,
        'team_assignment_date': firestore.SERVER_TIMESTAMP
    }, merge=True)
    
    # 6. Restituisci la casata assegnata
    return assigned_house
```

Questa funzione deve essere esposta tramite un URL accessibile dall'app Flutter, configurato nelle variabili di ambiente dell'app con la chiave `SORTING_CEREMONY_URL`.

## Implementazione App Flutter

### Flusso di lavoro sul Front-end

1. **Verifica necessità di smistamento**:
   La classe `UserNeedSortingCeremonyUseCase` controlla se un utente necessita della cerimonia di smistamento verificando se nei custom claims dell'utente è presente la chiave `team`.

2. **Inizializzazione cerimonia**:
   Il `SortingCeremonyCubit` gestisce lo stato dell'interfaccia durante il processo di cerimonia.

3. **Chiamata alla funzione di assegnazione**:
   Il metodo `startSortingCeremony()` del `SortingCeremonyCubit` attiva una chiamata all'`AssignTeamUseCase` che a sua volta chiama la funzione Firebase per l'assegnazione della casata.

4. **Visualizzazione risultato**:
   L'interfaccia mostra l'animazione di caricamento mentre la funzione viene eseguita, e poi mostra il risultato con l'assegnazione della casata.

### Flag di Feature

La funzionalità può essere abilitata o disabilitata tramite la costante `sortingCeremonyEnabled` nel file `sorting_ceremony.dart`. Quando disabilitata, il sistema salterà completamente la cerimonia di smistamento.

## Casate Disponibili

Le quattro casate si basano su tecnologie di programmazione diverse:

1. **Pytherin**: Focalizzata su Python e programmazione
2. **Kerasdor**: Specializzata in intelligenza artificiale e deep learning (Keras)
3. **Dashclaw**: Centrata su UI e Dash (framework Python per applicazioni web)
4. **Gopherpuff**: Dedicata al linguaggio Go e sistemi efficienti

## Note per Sviluppatori

- Assicuratevi che la funzione Firebase sia correttamente configurata e accessibile dall'app
- Verificate che l'URL della funzione sia correttamente impostato nella variabile d'ambiente `SORTING_CEREMONY_URL`
- La funzionalità può essere completamente disattivata impostando `sortingCeremonyEnabled = false`
- In caso di errore durante la chiamata alla funzione, viene mostrato un messaggio di errore attraverso lo stato `SortingCeremonyFailure`
- Se l'utente ha già una casata assegnata (codice errore 'already-exists'), il sistema procede comunque al completamento del flusso
