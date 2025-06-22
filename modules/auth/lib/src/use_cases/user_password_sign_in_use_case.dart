import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/custom_errors.dart';

@lazySingleton
class UserPasswordSignInUseCase {
  UserPasswordSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call(String email, String password) async {
    return runSafetyFuture(
      () => _auth.signInWithEmailAndPassword(email: email, password: password),
      onError: (e) {
        if (e is FirebaseAuthException) {
          return FirebaseAuthError(e);
        }
        return e;
      },
    );
  }
}
