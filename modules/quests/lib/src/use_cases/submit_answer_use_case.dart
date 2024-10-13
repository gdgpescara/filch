import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/quest.dart';

@lazySingleton
class SubmitAnswerUseCase {
  SubmitAnswerUseCase(
    this._functions,
  );

  final FirebaseFunctions _functions;

  Future<(bool, int)> call(Quest quest, List<int> answers) {
    return runSafetyFuture(
      () async {
        const url = String.fromEnvironment('SUBMIT_ANSWER_URL');
        final result = await _functions.httpsCallableFromUrl(url).call<bool>({
          'quest': quest.id,
          'answers': answers,
        });
        return (
          result.data,
          quest.points.first,
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
