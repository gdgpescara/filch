import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../schedule.dart';

@lazySingleton
class GetRoomsUseCase {
  GetRoomsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<NamedEntity>> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('rooms').snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) => NamedEntity.fromJson({
                'id': doc.id,
                ...doc.data(),
              }),
            )
            .toList();
      });
    });
  }
}
