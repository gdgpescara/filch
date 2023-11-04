import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsSignedUserNimbusUserUseCase {
  IsSignedUserNimbusUserUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<bool> call() async {
    final idToken = await _auth.currentUser!.getIdTokenResult(true);
    return idToken.claims?['isNimbusUser'] as bool? ?? false;
  }
}
