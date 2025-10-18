import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class GetTeamUseCase {
  GetTeamUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Future<Team?> call(String teamId) {
    return runSafetyFuture(() async {
      final snapshot = await _firestore.collection('teams').doc(teamId).get();
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return Team.fromJson({...snapshot.data()!, 'id': snapshot.id});
    });
  }
}
