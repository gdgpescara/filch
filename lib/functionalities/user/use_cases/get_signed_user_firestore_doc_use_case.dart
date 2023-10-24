import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';
import '../models/firestore_user.dart';

@lazySingleton
class GetSignedUserFirestoreDocUseCase {
  GetSignedUserFirestoreDocUseCase(
    this._firestore,
    this._auth,
  );

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<FirestoreUser?> call() {
    return runSafetyFuture(() async {
      final user = _auth.currentUser;
      if (user == null) {
        return null;
      }
      final firestoreUserSnap = await _firestore.collection('users').doc(user.uid).get();
      if (!firestoreUserSnap.exists) {
        return null;
      }
      final fuser = FirestoreUser.fromJson({...?firestoreUserSnap.data(), 'uid': user.uid});
      if(fuser.activeQuest != null) {
        await _firestore.collection('quests').doc().set(fuser.activeQuest!.quest.toJson());
      }
      return fuser;
    });
  }
}
