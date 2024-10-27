import 'dart:io';

import 'package:core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadCommunityQuestPhotoUseCase {
  const UploadCommunityQuestPhotoUseCase(this._storageRef);

  final Reference _storageRef;

  Future<String> call(File photo) {
    return runSafetyFuture(() async {
      final photoRef = _storageRef.child('community_quest_photos/${DateTime.now().millisecondsSinceEpoch}_${photo.name}');
      final photoData = await photo.readAsBytes();
      final task = await photoRef.putData(photoData);
      return task.ref.getDownloadURL();
    });
  }
}
