import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/error_catcher.dart';
import '../../_shared/models/house.dart';

@lazySingleton
class GetHousesUseCase {
  GetHousesUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<House>> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('houses')
          .orderBy('points', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => House.fromJson({'id': doc.id, ...doc.data()})).toList());
    });
  }
}
