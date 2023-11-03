import 'package:injectable/injectable.dart';

import '../../../common_functionalities/use_cases/get_feature_flags_use_case.dart';

@lazySingleton
class CanRequestForQuestUseCase {
  CanRequestForQuestUseCase(this._getFeatureFlagsUseCase);

  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  Future<bool> call() async {
    final featureFlag = await _getFeatureFlagsUseCase();
    return (featureFlag['actorQuestEnabled'] ?? false) ||
        (featureFlag['quizQuestEnabled'] ?? false) ||
        (featureFlag['socialQuestEnabled'] ?? false);
  }
}
