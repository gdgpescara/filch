import 'package:injectable/injectable.dart';

import '../../models/quest.dart';

@lazySingleton
class ValidateQuizQrCodeUseCase {
  ValidateQuizQrCodeUseCase();

  Future<bool> call(Quest quest, String scannedQrCode) async {
    return quest.qrCode == scannedQrCode;
  }
}
