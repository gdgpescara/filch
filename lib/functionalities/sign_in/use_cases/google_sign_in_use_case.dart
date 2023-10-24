import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';

@lazySingleton
class GoogleSignInUseCase {
  GoogleSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call() async {
    return runSafetyFuture(() {
      final googleProvider = GoogleAuthProvider();
      return _auth.signInWithProvider(googleProvider);
    });
  }
}
