import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMaxRoomDelayUseCase {
  GetMaxRoomDelayUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<int> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('room_delays').snapshots().map((querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return 0;
        }

        return querySnapshot.docs
            .where((doc) => doc.data().isNotEmpty && doc.data()['delay'] is int)
            .map((doc) => doc.data()['delay'] as int)
            .fold(0, (max, delay) => delay > max ? delay : max);
      });
    });
  }
}
