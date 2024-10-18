import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HasUserPickedTShirtUseCase {
  HasUserPickedTShirtUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<bool> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('users')
          .doc(_getSignedUserUseCase()?.uid)
          .snapshots()
          .map((snapshot) {
        final tShirtPickup = snapshot['tShirtPickup'];
        return tShirtPickup is bool && tShirtPickup;
      });
    });
  }
}
