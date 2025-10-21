import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserNeedSortingCeremonyUseCase {
  UserNeedSortingCeremonyUseCase(this._auth, this._signOutUseCase, this._firestore);

  final FirebaseAuth _auth;
  final SignOutUseCase _signOutUseCase;

  final FirebaseFirestore _firestore;

  Future<bool> call() async {
    final featureFlagsDoc = await _firestore.collection('configurations').doc('feature_flags').get();
    final featureFlags = featureFlagsDoc.data() ?? {};
    final sortingCeremonyEnabled = (featureFlags['sortingCeremony'] as bool?) ?? false;
    if (!sortingCeremonyEnabled) {
      return false;
    }
    return runSafetyFuture(
      () async {
        final idToken = await _auth.currentUser!.getIdTokenResult(true);
        final claims = idToken.claims;
        if (claims == null || claims.containsKey('staff') || claims.containsKey('sponsor')) {
          return false;
        }
        return !claims.containsKey('team');
      },
      onError: (e) {
        _signOutUseCase();
        return e;
      },
    );
  }
}
