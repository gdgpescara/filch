import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterRoomDelayUseCase {
  RegisterRoomDelayUseCase(this._functions);

  final FirebaseFunctions _functions;

  Future<bool> call(String roomId, int delay) async {
    const url = String.fromEnvironment('ADD_ROOM_DELAY_URL');
    final result = await _functions.httpsCallableFromUrl(url).call<bool>({
      'roomId': roomId,
      'delay': delay.toString(),
    });
    return result.data;
  }
}
