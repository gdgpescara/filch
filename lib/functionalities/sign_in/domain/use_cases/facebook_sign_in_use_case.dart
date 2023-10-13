import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/error_catcher.dart';

@lazySingleton
class FacebookSignInUseCase {
  FacebookSignInUseCase();


  Future<UserCredential> call() async {
    return runSafetyFuture(() async {
      final loginResult = await FacebookAuth.instance.login();
      final credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return FirebaseAuth.instance.signInWithCredential(credential);
    });
  }
}
