import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SocialQuestRegistrationUseCase {
  SocialQuestRegistrationUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<Map<String, String>> call({required Map<String, dynamic> payload, required String functionUrl}) {
    return runSafetyFuture(() async {
      final result = await _functions.httpsCallableFromUrl(functionUrl).call<Map<String, dynamic>>(payload);
      return result.data.map((key, value) => MapEntry(key, value.toString()));
    }, onError: onFirebaseFunctionError);
  }
}
