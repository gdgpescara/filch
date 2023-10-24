import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';
import '../../quests/models/active_quest.dart';
import 'get_signed_user_firestore_doc_use_case.dart';

@lazySingleton
class GetSignedUserActiveQuestUseCase {
  GetSignedUserActiveQuestUseCase(
    this._getSignedUserFirestoreDocUseCase,
  );

  final GetSignedUserFirestoreDocUseCase _getSignedUserFirestoreDocUseCase;

  Future<ActiveQuest?> call() {
    return runSafetyFuture(() async {
      final firestoreUser = await _getSignedUserFirestoreDocUseCase();
      return firestoreUser?.activeQuest;
    });
  }
}
