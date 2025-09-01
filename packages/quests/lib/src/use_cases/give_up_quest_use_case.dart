import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GiveUpQuestUseCase {
  GiveUpQuestUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call() {
    return runSafetyFuture(() async {
      const url = String.fromEnvironment('REMOVE_ACTIVE_QUEST_URL');
      final result = await _functions.httpsCallableFromUrl(url).call<bool>();
      return result.data;
    }, onError: onFirebaseFunctionError);
  }
}
