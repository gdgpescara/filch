import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../error_handling/failure.dart';

@lazySingleton
class AppleSignInUseCase {
  AppleSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() async {
    return runSafetyFuture(
      () {
        final appleProvider = AppleAuthProvider();
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
