import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/ranking_item.dart';

@lazySingleton
class GetRankingUseCase {
  GetRankingUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<RankingItem>> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('users')
          .where('isStaff', isNotEqualTo: true)
          .orderBy('points', descending: true)
          .limit(10)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => RankingItem.fromJson({...doc.data(), 'uid': doc.id})).toList());
    });
  }
}
