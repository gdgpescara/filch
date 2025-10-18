import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/shift.dart';

@lazySingleton
class GetFilteredShiftsUseCase {
  GetFilteredShiftsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<List<Shift>> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('shifts')
          .where(
            'start',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            ),
          )
          .snapshots()
          .map((value) => value.docs.map((e) => Shift.fromJson(e.data())).toList());
    });
  }
}
