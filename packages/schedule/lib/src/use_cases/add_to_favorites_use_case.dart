import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddToFavoritesUseCase {
  AddToFavoritesUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  /// Adds a session to the user's favorites
  ///
  /// Throws [Exception] if user is not signed in
  Future<void> call(String sessionId) async {
    final user = _getSignedUserUseCase();
    if (user == null) {
      throw Exception('User must be signed in to add favorites');
    }

    await _firestore.collection('users').doc(user.uid).collection('favorite_sessions').doc(sessionId).set({
      'sessionId': sessionId,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }
}
