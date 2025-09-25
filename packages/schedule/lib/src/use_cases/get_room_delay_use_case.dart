import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/room_delay.dart';

@lazySingleton
class GetRoomDelayUseCase {
  GetRoomDelayUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<RoomDelay?> call(String roomId) {
    return runSafetyStream(() async* {
      yield* _firestore.collection('room_delays').doc(roomId).snapshots().map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return null;
        }
        return RoomDelay.fromJson({
          'id': snapshot.id,
          ...snapshot.data()!,
        });
      });
    });
  }
}
