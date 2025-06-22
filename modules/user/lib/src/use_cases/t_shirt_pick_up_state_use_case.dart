import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/t_shirt_pick_up_state.dart';

@lazySingleton
class TShirtPickUpStateUseCase {
  TShirtPickUpStateUseCase(this._firestore, this._getSignedUserUseCase);

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<TShirtPickUpState> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('users').doc(_getSignedUserUseCase()?.uid).snapshots().map((snapshot) {
        final tShirtPickup = snapshot['tShirtPickup'];
        final tShirtPickupRequested = snapshot['tShirtPickupRequested'];
        if (tShirtPickup is bool && tShirtPickup) {
          return TShirtPickUpState.pickedUp;
        }
        if (tShirtPickupRequested is bool && tShirtPickupRequested) {
          return TShirtPickUpState.requested;
        }
        return TShirtPickUpState.none;
      });
    });
  }
}
