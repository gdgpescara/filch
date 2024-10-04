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
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<RankingItem?> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('users').doc(_getSignedUserUseCase()?.uid).snapshots().map(
        (snapshot) {
          if (snapshot.exists) {
            return RankingItem.fromJson({...snapshot.data()!, 'uid': snapshot.id});
          } else {
            return null;
          }
        },
      );
    });
  }
}
