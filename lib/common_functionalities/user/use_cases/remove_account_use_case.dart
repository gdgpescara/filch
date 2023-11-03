import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';

@lazySingleton
class RemoveAccountUseCase {
  RemoveAccountUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<void> call() {
    return runSafetyFuture(() => _auth.currentUser!.delete());
  }
}
