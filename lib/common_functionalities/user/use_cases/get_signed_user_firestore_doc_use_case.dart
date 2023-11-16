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

  Stream<FirestoreUser?> call() {
    return runSafetyStream(() async* {
      final user = _auth.currentUser;
      if (user == null) {
        yield null;
        return;
      }
      yield* _firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
        if (!snapshot.exists) {
          return null;
        }
        return FirestoreUser.fromJson({...?snapshot.data(), 'uid': user.uid});
      });
    });
  }
}
