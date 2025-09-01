import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssignTeamUseCase {
  AssignTeamUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<String> call() async {
    return runSafetyFuture(() async {
      const url = String.fromEnvironment('SORTING_CEREMONY_URL');
      final result = await _functions.httpsCallableFromUrl(url).call<String>();
      return result.data;
    }, onError: onFirebaseFunctionError);
  }
}
