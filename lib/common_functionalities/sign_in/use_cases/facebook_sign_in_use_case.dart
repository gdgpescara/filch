import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../error_handling/failure.dart';

@lazySingleton
class FacebookSignInUseCase {
  FacebookSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() async {
    return runSafetyFuture(() async {
      final loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
      final credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return _auth.signInWithCredential(credential);
    },
      onException: (e) {
        if (e is FirebaseAuthException) {
          return Failure(code: e.code, message: e.message ?? '');
        }
        return Failure.genericFromException(e);
      },);
  }
}
