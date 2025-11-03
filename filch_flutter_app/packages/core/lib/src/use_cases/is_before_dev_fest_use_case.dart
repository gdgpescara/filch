import 'package:injectable/injectable.dart';

import '../../core.dart';

@lazySingleton
class IsBeforeDevFestUseCase {
  IsBeforeDevFestUseCase(this._getFeatureFlagsUseCase);

  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  Stream<bool> call() {
    return runSafetyStream(() {
      return _getFeatureFlagsUseCase().map((data) {
        return data['beforeDevFest'] ?? false;
      });
    });
  }
}
