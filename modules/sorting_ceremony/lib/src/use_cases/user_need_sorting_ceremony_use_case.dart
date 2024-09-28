import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart';


@lazySingleton
class UserNeedSortingCeremonyUseCase {
  UserNeedSortingCeremonyUseCase(
    this._auth,
    this._signOutUseCase,
  );

  final FirebaseAuth _auth;
  final SignOutUseCase _signOutUseCase;

  Future<bool> call() async {
    if(!sortingCeremonyEnabled) {
      return false;
    }
    return runSafetyFuture(
      () async {
        final idToken = await _auth.currentUser!.getIdTokenResult(true);
        return !(idToken.claims?.containsKey('team') ?? true);
      },
      onException: (e) {
        _signOutUseCase();
        return Failure.genericFromException(e);
      },
    );
  }
}
