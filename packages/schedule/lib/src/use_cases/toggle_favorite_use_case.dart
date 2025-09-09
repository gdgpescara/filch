import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  /// Toggles a session in/out of favorites
  ///
  /// Returns true if the session was added to favorites, false if removed
  /// Throws [Exception] if user is not signed in
  Future<bool> call(String sessionId) async {
    final user = _getSignedUserUseCase();
    if (user == null) {
      throw Exception('User must be signed in to toggle favorites');
    }

    final docRef = _firestore.collection('users').doc(user.uid).collection('favorite_sessions').doc(sessionId);

    final doc = await docRef.get();

    if (doc.exists) {
      // Remove from favorites
      await docRef.delete();
      return false;
    } else {
      // Add to favorites
      await docRef.set({
        'sessionId': sessionId,
        'addedAt': FieldValue.serverTimestamp(),
      });
      return true;
    }
  }
}
