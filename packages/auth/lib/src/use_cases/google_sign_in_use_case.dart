import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../models/custom_errors.dart';

@lazySingleton
class GoogleSignInUseCase {
  GoogleSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() async {
    return runSafetyFuture(
      () async {
        final googleUser = await GoogleSignIn(scopes: ['profile']).signIn();
        if (googleUser == null) {
          throw UserUnauthenticatedError();
        }
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return _auth.signInWithCredential(credential);
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
