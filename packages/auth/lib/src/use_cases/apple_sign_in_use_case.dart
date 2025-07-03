import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/custom_errors.dart';

@lazySingleton
class AppleSignInUseCase {
  AppleSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() {
    return runSafetyFuture(
      () {
        final appleProvider = AppleAuthProvider()
          ..addScope('email')
          ..addScope('name');
        return _auth.signInWithProvider(appleProvider);
      },
      onError: (e) {
        if (e is FirebaseAuthException) {
          return FirebaseAuthError(e);
        }
        return e;
      },
    );
  }
}
