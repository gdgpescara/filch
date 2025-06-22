import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/active_quest.dart';
import 'get_signed_user_active_quest_use_case.dart';

@lazySingleton
class SearchForQuestUseCase {
  SearchForQuestUseCase(this._functions, this._getSignedUserActiveQuestUseCase);

  final FirebaseFunctions _functions;
  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;

  Future<ActiveQuest> call() {
    return runSafetyFuture(() async {
      const url = String.fromEnvironment('SEARCH_FOR_QUEST_URL');
      await _functions.httpsCallableFromUrl(url).call<void>();
      final activeQuest = await _getSignedUserActiveQuestUseCase().first;
      if (activeQuest == null) {
        throw NotFoundError();
      }
      return activeQuest;
    }, onError: onFirebaseFunctionError);
  }
}
