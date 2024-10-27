import 'dart:io';

import 'package:core/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TakePhotoUseCase {
  TakePhotoUseCase(this._imagePicker);

  final ImagePicker _imagePicker;

  Future<File?> call() {
    return runSafetyFutureNullable(() async {
      final file = await _imagePicker.pickImage(source: ImageSource.camera);
      if (file != null) {
        return File(file.path).renameFile('photo_${DateTime.now().millisecondsSinceEpoch}');
      }

      throw Failure(message: 'No file selected');
    });
  }
}
