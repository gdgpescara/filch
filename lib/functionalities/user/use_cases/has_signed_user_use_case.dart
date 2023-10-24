import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class HasSignedUserUseCase {
  HasSignedUserUseCase(this._auth);
  final FirebaseAuth _auth;

  bool call() {
    return _auth.currentUser != null && _auth.currentUser?.getIdToken() != null;
  }
}
