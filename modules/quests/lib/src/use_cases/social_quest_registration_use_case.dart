import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SocialQuestRegistrationUseCase {
  SocialQuestRegistrationUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call({required Map<String, dynamic> payload, required String functionUrl}) {
    return runSafetyFuture(() async {
      final result = await _functions.httpsCallableFromUrl(functionUrl).call<bool>(payload);
      return result.data;
    }, onError: onFirebaseFunctionError);
  }
}
