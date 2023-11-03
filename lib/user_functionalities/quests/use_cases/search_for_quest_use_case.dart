import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../../../common_functionalities/error_handling/failure.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_active_quest_use_case.dart';
import '../models/active_quest.dart';

@lazySingleton
class SearchForQuestUseCase {
  SearchForQuestUseCase(
    this._functions,
    this._getSignedUserActiveQuestUseCase,
  );

  final FirebaseFunctions _functions;
  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;

  Future<ActiveQuest> call() {
    return runSafetyFuture(
      () async {
        const url = String.fromEnvironment('SEARCH_FOR_QUEST_URL');
        await _functions.httpsCallableFromUrl(url).call<void>();
        final activeQuest = await _getSignedUserActiveQuestUseCase();
        if (activeQuest == null) {
          throw NotFoundFailure();
        }
        return activeQuest;
      },
      onException: (e) {
        if (e is FirebaseFunctionsException) {
          return FirebaseFunctionsFailure(e);
        }
        return Failure.genericFromException(e);
      },
    );
  }
}
