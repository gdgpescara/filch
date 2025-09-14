import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsStaffUserUseCase {
  IsStaffUserUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<bool> call() {
    return runSafetyFuture(() async {
      final idTokenResult = await _auth.currentUser?.getIdTokenResult();
      return idTokenResult?.claims?['isStaff'] == true;
    });
  }
}
