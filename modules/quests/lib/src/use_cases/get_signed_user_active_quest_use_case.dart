import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/active_quest.dart';

@lazySingleton
class GetSignedUserActiveQuestUseCase {
  GetSignedUserActiveQuestUseCase(
    this._firestore,
    this._auth,
  );

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Stream<ActiveQuest?> call() {
    return runSafetyStream(() async* {
      final user = _auth.currentUser;
      if (user == null) {
        yield null;
        return;
      }
      yield* _firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return null;
        }
        final activeQuestJson = snapshot.data()!['activeQuest'] as Map<String, dynamic>?;
        if (activeQuestJson == null) {
          return null;
        }
        return ActiveQuest.fromJson(activeQuestJson);
      });
    });
  }
}
