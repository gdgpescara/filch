import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/error_catcher.dart';
import '../../../_shared/error_handling/failure.dart';
import '../../../user/use_cases/get_signed_user_active_quest_use_case.dart';
import '../../models/active_quest.dart';

@lazySingleton
class SearchForQuestUseCase {
  SearchForQuestUseCase(
    this._functions,
    this._getSignedUserActiveQuestUseCase,
  );

  final FirebaseFunctions _functions;
  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;

  Future<ActiveQuest> call() async {
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
