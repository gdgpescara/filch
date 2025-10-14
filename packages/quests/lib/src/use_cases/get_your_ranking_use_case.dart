import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import '../models/ranking_item.dart';

@lazySingleton
class GetYourRankingUseCase {
  GetYourRankingUseCase(
    this._firestore,
    this._getSignedUserUseCase,
    this._staffUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;
  final IsSponsorUserUseCase _staffUserUseCase;

  Stream<RankingItem?> call() {
    return runSafetyStream(() async* {
      if (await _staffUserUseCase()) {
        yield null;
        return;
      }
      final user = _getSignedUserUseCase();
      if (user == null) {
        yield null;
        return;
      }
      yield* _firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
        if (snapshot.exists) {
          return RankingItem.fromJson({...snapshot.data()!, 'uid': snapshot.id});
        } else {
          return null;
        }
      });
    });
  }
}
