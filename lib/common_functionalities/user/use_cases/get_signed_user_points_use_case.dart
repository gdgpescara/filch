import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../models/points.dart';
import 'get_signed_user_use_case.dart';

@lazySingleton
class GetSignedUserPointsUseCase {
  GetSignedUserPointsUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<List<Points>> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('users')
          .doc(_getSignedUserUseCase()?.uid)
          .collection('points')
          .orderBy('assignedAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) => Points.fromJson(doc.data())).toList(),
          );
    });
  }
}
