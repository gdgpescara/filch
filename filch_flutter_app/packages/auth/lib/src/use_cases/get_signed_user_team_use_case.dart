import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSignedUserTeamUseCase {
  GetSignedUserTeamUseCase(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<Team?> call() {
    return runSafetyFuture(() async {
      final idTokenResult = await _auth.currentUser?.getIdTokenResult();
      final teamId = idTokenResult?.claims?['team'] as String?;
      if (teamId == null) {
        return null;
      }
      final snapshot = await _firestore.collection('teams').doc(teamId).get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return Team.fromJson({...snapshot.data()!, 'id': snapshot.id});
    });
  }
}
