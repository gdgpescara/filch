import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../auth.dart';

@lazySingleton
class UploadFcmTokenUseCase {
  UploadFcmTokenUseCase(this._firestore, this._firebaseMessaging, this._getSignedUserUseCase);

  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Future<void> call() {
    return runSafetyFuture(() async {
      final token = await _firebaseMessaging.getToken();
      final userUid = _getSignedUserUseCase()?.uid;
      if (token != null && userUid != null) {
        await _firestore.collection('users').doc(userUid).update({'fcmToken': token});
      }
    });
  }
}
