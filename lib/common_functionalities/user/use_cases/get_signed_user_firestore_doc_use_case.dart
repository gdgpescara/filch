import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
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
      return FirestoreUser.fromJson({...?firestoreUserSnap.data(), 'uid': user.uid});
    });
  }
}
