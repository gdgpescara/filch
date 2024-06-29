import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthStateChangesUseCase {
  AuthStateChangesUseCase(this._auth);

  final FirebaseAuth _auth;

  Stream<User> call() {
    return runSafetyStream(() {
      return _auth.authStateChanges().map((user) {
        if (user == null) {
          throw Failure(message: 'Unauthenticated');
        }
        return user;
      });
    });
  }
}
