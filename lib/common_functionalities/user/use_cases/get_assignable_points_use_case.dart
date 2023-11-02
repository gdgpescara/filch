import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/error_catcher.dart';
import '../../models/assignable_points.dart';

@lazySingleton
class GetAssignablePointsUseCase {
  GetAssignablePointsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<AssignablePoints>> call() {
    return runSafetyStream(() {
      return _firestore
          .collection('assignable_points')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => AssignablePoints.fromJson(doc.data())).toList());
    });
  }
}
