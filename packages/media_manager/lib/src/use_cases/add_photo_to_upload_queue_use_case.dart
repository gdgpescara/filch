import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../media_manager.dart';

@lazySingleton
class AddPhotoToUploadQueueUseCase {
  AddPhotoToUploadQueueUseCase(this._firestore, this._getSignedUserUseCase);

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Future<void> call(String path, PhotoType photoType) {
    return runSafetyFuture(() async {
      final user = _getSignedUserUseCase();
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('photo_queue').add({
          'path': path,
          'status': 'pending',
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    });
  }
}
