import 'package:injectable/injectable.dart';

import '../../../common_functionalities/use_cases/get_feature_flags_use_case.dart';

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
