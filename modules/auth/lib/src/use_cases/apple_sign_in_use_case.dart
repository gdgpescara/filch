import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

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
      onException: (e) {
        if (e is FirebaseAuthException) {
          return Failure(code: e.code, message: e.message ?? '');
        }
        return Failure.genericFromException(e);
      },
    );
  }
}
