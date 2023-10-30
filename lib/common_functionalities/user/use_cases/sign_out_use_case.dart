import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUseCase {
  SignOutUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<void> call() {
    return _auth.signOut();
  }
}
