import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsRankingFreezedUseCase {
  IsRankingFreezedUseCase(this._getFeatureFlagsUseCase);

  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  Stream<bool> call() {
    return _getFeatureFlagsUseCase().map((featureFlag) {
      return featureFlag['freezeRanking'] ?? false;
    });
  }
}
