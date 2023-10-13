import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/error_catcher.dart';

@lazySingleton
class TwitterSignInUseCase {
  TwitterSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() async {
    return runSafetyFuture(() {
      final twitterProvider = TwitterAuthProvider();
      return _auth.signInWithProvider(twitterProvider);
    });
  }
}
