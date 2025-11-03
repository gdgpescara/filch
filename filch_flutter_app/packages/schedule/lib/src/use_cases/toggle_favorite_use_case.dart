import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call(String sessionId) async {
    const url = String.fromEnvironment('TOGGLE_FAVORITE_SESSION_URL');
    final result = await _functions.httpsCallableFromUrl(url).call<bool>({
      'sessionId': sessionId,
    });
    return result.data;
  }
}
