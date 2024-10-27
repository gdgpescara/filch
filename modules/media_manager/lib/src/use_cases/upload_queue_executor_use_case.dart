import 'dart:async';
import 'dart:io';

import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

import '../../media_manager.dart';

@lazySingleton
class UploadQueueExecutorUseCase {
  UploadQueueExecutorUseCase(
    this._firestore,
    this._getSignedUserUseCase,
    this._uploadCommunityQuestPhotoUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;
  final UploadCommunityQuestPhotoUseCase _uploadCommunityQuestPhotoUseCase;

  StreamSubscription<void>? call() {
    final user = _getSignedUserUseCase();
    if (user != null) {
      final collection = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('photo_queue');

     return collection
          .where('status', isNotEqualTo: 'uploading')
          .snapshots()
          .when(
        success: (snapshot) {
          for (final doc in snapshot.docs) {
            final path = doc.data()['path'] as String;
            if (path.contains(PhotoType.communityQuest.directoryName)) {
              final file = File(path);
              if(file.existsSync()){
                _uploadCommunityQuestPhotoUseCase(file).when(
                  progress: () {
                    collection.doc(doc.id).update({'status': 'uploading'});
                  },
                  success: (_) {
                    doc.reference.delete();
                    file.delete();
                  },
                  failure: (failure) {
                    collection.doc(doc.id).update({'status': 'failed', 'error': failure.message});
                  },
                );
              } else {
                doc.reference.delete();
              }
            }
          }
        },
        failure:(e)=> FirebaseCrashlytics.instance.recordError(e, StackTrace.current),
      );
    }
    return null;
  }
}
