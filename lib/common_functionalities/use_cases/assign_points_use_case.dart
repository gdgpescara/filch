import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

import '../error_handling/error_catcher.dart';
import '../error_handling/failure.dart';
import '../models/points_type_enum.dart';

@lazySingleton
class AssignPointsUseCase {
  AssignPointsUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call({
    required int points,
    required List<String> users,
    required PointsTypeEnum pointsType,
    String? quest,
  }) {
    return runSafetyFuture(
      () async {
        const url = String.fromEnvironment('ASSIGN_POINTS_URL');
        final result = await _functions.httpsCallableFromUrl(url).call<bool>({
          'points': points,
          'users': users,
          'quest': quest,
          'type': pointsType.name,
        });
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
