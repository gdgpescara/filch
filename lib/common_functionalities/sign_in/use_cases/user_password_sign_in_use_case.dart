import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';

@lazySingleton
class UserPasswordSignInUseCase {
  UserPasswordSignInUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<UserCredential> call(String email, String password) async {
    return runSafetyFuture(() => _auth.signInWithEmailAndPassword(email: email, password: password));
  }
}
