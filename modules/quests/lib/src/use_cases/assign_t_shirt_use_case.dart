import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssignTShirtUseCase {
  AssignTShirtUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call(String user) {
    return runSafetyFuture(
      () async {
        const url = String.fromEnvironment('ASSIGN_T_SHIRT_URL');
        final result = await _functions
            .httpsCallableFromUrl(url)
            .call<bool>({'user': user});
        return result.data;
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
