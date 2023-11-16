import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../../../common_functionalities/models/house_detail.dart';

@lazySingleton
class GetWinnerHouseUseCase {
  GetWinnerHouseUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Future<HouseDetail> call() {
    return runSafetyFuture(() async {
      final results = await _firestore.collection('houses').orderBy('points', descending: true).limit(1).get();

      if (results.docs.isEmpty) {
        throw Exception('No winning house found');
      }

      final members =
          await results.docs.first.reference.collection('members').orderBy('points', descending: true).get();
      return HouseDetail.fromJson(
        {
          'id': results.docs.first.id,
          'points': results.docs.first.data()['points'],
          'members': members.docs.map((e) => e.data()).toList(),
        },
      );
    });
  }
}
