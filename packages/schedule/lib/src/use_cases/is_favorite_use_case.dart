import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsFavoriteUseCase {
  IsFavoriteUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  /// Returns a stream that indicates whether a specific session is favorited
  ///
  /// The stream will emit false if the user is not signed in
  Stream<bool> call(String sessionId) {
    return runSafetyStream(() {
      final user = _getSignedUserUseCase();
      if (user == null) {
        return Stream.value(false);
      }

      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorite_sessions')
          .doc(sessionId)
          .snapshots()
          .map((snapshot) => snapshot.exists);
    });
  }
}
