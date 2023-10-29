import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';
import '../../_shared/models/points.dart';
import 'get_signed_user_use_case.dart';

@lazySingleton
class GetSignedUserArchivedQuestsUseCase {
  GetSignedUserArchivedQuestsUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Future<List<ArchivedQuest>> call() {
    return runSafetyFuture(() async {
      final archivedQuestsSnap =
          await _firestore.collection('users').doc(_getSignedUserUseCase()!.uid).collection('quests_archived').get();
      return archivedQuestsSnap.docs.map((e) => ArchivedQuest.fromJson(e.data())).toList();
    });
  }
}
