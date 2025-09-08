import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/session.dart';

@lazySingleton
class GetSessionByIdUseCase {
  GetSessionByIdUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  /// Retrieves a session by its ID
  ///
  /// Returns a [Stream<Session?>] that emits the session data when found,
  /// or null if the session doesn't exist.
  /// The stream will update automatically if the session data changes.
  Stream<Session> call(String sessionId) {
    return runSafetyStream(() {
      return _firestore.collection('sessions').doc(sessionId).snapshots().map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          throw NotFoundError();
        }

        try {
          return Session.fromJson({
            'id': snapshot.id,
            ...snapshot.data()!,
          });
        } catch (e) {
          throw GenericError(message: 'Invalid session data');
        }
      });
    });
  }
}
