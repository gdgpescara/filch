import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetYourRankingPositionUseCase {
  GetYourRankingPositionUseCase(this._firestore, this._getSignedUserUseCase);

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<int?> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('users')
          .where('staff', isNotEqualTo: true)
          .where('sponsor', isEqualTo: false)
          .orderBy('points', descending: true)
          .snapshots()
          .map((
            snapshot,
          ) {
            final docs = snapshot.docs;
            final user = _getSignedUserUseCase();
            final userIndex = docs.indexWhere((doc) => doc.id == user?.uid);
            return userIndex == -1 ? null : userIndex + 1;
          });
    });
  }
}
