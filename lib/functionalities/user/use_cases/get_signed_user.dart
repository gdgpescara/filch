import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSignedUserUseCase {
  GetSignedUserUseCase(this._auth);
  final FirebaseAuth _auth;

  User? call() {
    return _auth.currentUser;
  }
}
