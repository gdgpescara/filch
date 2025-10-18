import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncSessionizeUseCase {
  SyncSessionizeUseCase(this._functions, this._firestore);

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  Future<bool> call() async {
    final sessionizeSnapshot = await _firestore
        .collection('configurations')
        .doc('sessionize')
        .get();
    final eventId = sessionizeSnapshot.data()?['eventId'] as String?;
    const url = String.fromEnvironment('SYNC_SESSIONIZE_URL');
    final result = await _functions.httpsCallableFromUrl(url).call<bool>({
      'event_id': eventId,
    });
    return result.data;
  }
}
