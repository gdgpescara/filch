import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/error_catcher.dart';
import '../../../_shared/error_handling/failure.dart';

@lazySingleton
class AssignHouseUseCase {
  AssignHouseUseCase(
    this._functions,
  );

  final FirebaseFunctions _functions;

  Future<String> call() async {
    return runSafetyFuture(
      () async {
        final result =
            await _functions.httpsCallableFromUrl(const String.fromEnvironment('SORTING_CEREMONY_URL')).call<String>();
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
