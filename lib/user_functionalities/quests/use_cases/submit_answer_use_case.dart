import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../../../common_functionalities/error_handling/failure.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_house_use_case.dart';
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
          'quest': quest.id,
          'answers': answers,
        });
        return (
          result.data,
          quest.points,
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
