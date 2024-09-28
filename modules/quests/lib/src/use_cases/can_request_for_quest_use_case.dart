import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CanRequestForQuestUseCase {
  CanRequestForQuestUseCase(this._getFeatureFlagsUseCase);

  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  Stream<bool> call() {
    return _getFeatureFlagsUseCase().map((featureFlag) {
      return (featureFlag['actorQuestEnabled'] ?? false) ||
          (featureFlag['quizQuestEnabled'] ?? false) ||
          (featureFlag['socialQuestEnabled'] ?? false);
    });
  }
}
