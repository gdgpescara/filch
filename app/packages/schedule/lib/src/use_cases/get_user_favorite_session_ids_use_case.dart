import 'dart:async';

import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserFavoriteSessionIdsUseCase {
  GetUserFavoriteSessionIdsUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<Set<String>> call() {
    final user = _getSignedUserUseCase();
    if (user == null) {
      return Stream.value(<String>{});
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorite_sessions')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toSet());
  }
}
