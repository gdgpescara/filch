import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../error_handling/failure.dart';

@lazySingleton
class UserPasswordSignInUseCase {
  UserPasswordSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call(String email, String password) async {
    return runSafetyFuture(
      () => _auth.signInWithEmailAndPassword(email: email, password: password),
      onException: (e) {
        if (e is FirebaseAuthException) {
          return Failure(code: e.code, message: e.message ?? '');
        }
        return Failure.genericFromException(e);
      },
    );
  }
}
