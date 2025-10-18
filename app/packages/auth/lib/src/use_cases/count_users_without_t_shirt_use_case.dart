import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CountUsersWithoutTShirtUseCase {
  CountUsersWithoutTShirtUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<int> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('users').where('tShirtPickup', isEqualTo: false).snapshots().map((snapshot) {
        return snapshot.size;
      });
    });
  }
}
