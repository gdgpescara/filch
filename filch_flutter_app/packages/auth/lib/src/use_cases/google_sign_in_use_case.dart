import 'dart:io';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../models/custom_errors.dart';

@lazySingleton
class GoogleSignInUseCase {
  GoogleSignInUseCase(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Future<UserCredential> call() async {
    return runSafetyFuture(
      () async {
        GoogleSignInAccount? googleUser;
        if(Platform.isAndroid) {
          googleUser = await _googleSignIn.attemptLightweightAuthentication();
        }

        if (googleUser == null && _googleSignIn.supportsAuthenticate()) {
          googleUser = await _googleSignIn.authenticate(scopeHint: ['profile']);
        }

        if (googleUser == null) {
          throw UserUnauthenticatedError();
        }

        final googleAuth = googleUser.authentication;
        final authClient = googleUser.authorizationClient;
        final authorization = await authClient.authorizationForScopes(['profile']);

        if (authorization == null) {
          throw UserUnauthenticatedError();
        }

        final credential = GoogleAuthProvider.credential(
          accessToken: authorization.accessToken,
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
