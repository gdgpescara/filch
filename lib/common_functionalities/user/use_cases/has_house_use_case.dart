import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../error_handling/failure.dart';
import 'sign_out_use_case.dart';

@lazySingleton
class HasHouseUseCase {
  HasHouseUseCase(
    this._auth,
    this._signOutUseCase,
  );

  final FirebaseAuth _auth;
  final SignOutUseCase _signOutUseCase;

  Future<bool> call() async {
    return runSafetyFuture(
      () async {
        final idToken = await _auth.currentUser!.getIdTokenResult(true);
        return idToken.claims?.containsKey('house') ?? false;
      },
      onException: (e) {
        _signOutUseCase();
        return Failure.genericFromException(e);
      },
    );
  }
}
