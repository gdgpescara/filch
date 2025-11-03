import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HasSignedUserUseCase {
  HasSignedUserUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<bool> call() async {
    return await runSafetyFutureNullable(() async {
          return _auth.currentUser != null && (await _auth.currentUser?.getIdToken()) != null;
        }) ??
        false;
  }
}
