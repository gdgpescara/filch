import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/error_catcher.dart';
import '../../../_shared/error_handling/failure.dart';
import '../../../user/use_cases/get_signed_user.dart';
import '../../../user/use_cases/get_signed_user_firestore_doc_use_case.dart';
import '../../../user/use_cases/get_signed_user_house_use_case.dart';
import '../../models/archived_quest.dart';
import '../../models/quest.dart';

@lazySingleton
class SubmitAnswerUseCase {
  SubmitAnswerUseCase(
    this._firestore,
    this._getSignedUserUseCase,
    this._getSignedUserHouseUseCase,
    this._getSignedUserFirestoreDocUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;
  final GetSignedUserHouseUseCase _getSignedUserHouseUseCase;

  final GetSignedUserFirestoreDocUseCase _getSignedUserFirestoreDocUseCase;

  Future<(bool, int, String)> call(Quest quest, List<int> answers) {
    return runSafetyFuture(() async {
      final uid = _getSignedUserUseCase()?.uid;
      final correctAnswers = quest.answers?.where((answer) => answer.isCorrect).map((answer) => answer.id).toList();
      final firestoreUser = await _getSignedUserFirestoreDocUseCase();
      if (quest.answers == null || uid == null || correctAnswers == null || firestoreUser == null) {
        throw Failure.genericError();
      }
      final isCorrect = correctAnswers.every((e) => answers.contains(e));
      final house = await _getSignedUserHouseUseCase();
      final archivedQuest = ArchivedQuest(
        quest: quest,
        points: isCorrect ? quest.points : -quest.malus,
        uid: uid,
        archivedAt: DateTime.now(),
      );
      final batch = _firestore.batch()
        ..set(
          _firestore.collection('users').doc(uid).collection('quests_archived').doc(quest.id),
          archivedQuest.toJson(),
        )
        ..set(
          _firestore.collection('houses').doc(house).collection('quests_archived').doc(),
          archivedQuest.toJson(),
        )
        ..update(
          _firestore.collection('users').doc(uid),
          firestoreUser.removeActiveQuest().toJson(),
        );
      await batch.commit();
      return (
        isCorrect,
        isCorrect ? quest.points : quest.malus,
        house,
      );
    });
  }
}
