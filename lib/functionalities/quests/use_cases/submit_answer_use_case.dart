import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';
import '../../_shared/error_handling/failure.dart';
import '../../user/use_cases/get_signed_user_house_use_case.dart';
import '../models/quest.dart';

@lazySingleton
class SubmitAnswerUseCase {
  SubmitAnswerUseCase(
    this._functions,
    this._getSignedUserHouseUseCase,
  );

  final FirebaseFunctions _functions;
  final GetSignedUserHouseUseCase _getSignedUserHouseUseCase;

  Future<(bool, int, String)> call(Quest quest, List<int> answers) {
    return runSafetyFuture(
      () async {
        const url = String.fromEnvironment('SUBMIT_ANSWER_URL');
        final result = await _functions.httpsCallableFromUrl(url).call<bool>({
          'quest': quest.toJson(),
          'answers': answers,
        });
        return (
          result.data,
          result.data ? quest.points : quest.malus,
          await _getSignedUserHouseUseCase(),
        );
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
