import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/schedule.dart';

/// Esempio di utilizzo del GetSessionByIdUseCase
void main() async {
  // Inizializza Firestore (normalmente fatto attraverso dependency injection)
  final firestore = FirebaseFirestore.instance;
  
  // Crea l'istanza del use case
  final getSessionByIdUseCase = GetSessionByIdUseCase(firestore);
  
  // ID della session che vogliamo recuperare
  const sessionId = 'example-session-id';
  
  // Esempio 1: Ascoltare i cambiamenti in tempo reale
  print('🚀 Avvio del monitoraggio della session: $sessionId');
  
  final sessionStream = getSessionByIdUseCase.call(sessionId);
  
  sessionStream.listen(
    (session) {
      if (session != null) {
        print('✅ Session trovata:');
        print('   Titolo: ${session.title}');
        print('   Descrizione: ${session.description}');
        print('   Inizio: ${session.startsAt}');
        print('   Fine: ${session.endsAt}');
        print('   Stanza: ${session.room.name}');
        print('   Speakers: ${session.speakers.map((s) => s.fullName).join(', ')}');
        print('   Stato: ${_getSessionStatus(session)}');
      } else {
        print('❌ Session non trovata o dati non validi');
      }
    },
    onError: (Object error) {
      print('💥 Errore durante il recupero della session: $error');
    },
  );
  
  // Esempio 2: Recupero singolo (one-time fetch)
  // Nota: questo metodo non è ancora implementato, ma potrebbe essere utile
  // final session = await getSessionByIdUseCase.getOnce(sessionId);
  
  // Mantieni il programma in esecuzione per vedere gli aggiornamenti
  await Future<void>.delayed(const Duration(seconds: 30));
}

String _getSessionStatus(Session session) {
  if (session.isCurrentlyRunning) {
    return 'In corso 🔴';
  } else if (session.hasEnded) {
    return 'Terminata ✅';
  } else if (session.isUpcoming) {
    return 'Prossima ⏰';
  } else {
    return 'Sconosciuto ❓';
  }
}
