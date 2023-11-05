import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../models/shift.dart';

@lazySingleton
class GetFilteredShiftsUseCase {
  GetFilteredShiftsUseCase(
    this._firestore,
  );

  final FirebaseFirestore _firestore;

  Stream<List<Shift>> call() {
    return runSafetyStream(() async* {
      yield* _firestore
          .collection('shifts')
          .where(
            'start',
            isGreaterThan: Timestamp.fromDate(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0)),
          )
          .snapshots()
          .map((value) => value.docs.map((e) => Shift.fromJson(e.data())).toList());
    });
  }
}
