import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../../../common_functionalities/models/house.dart';

@lazySingleton
class GetWinnerHouseUseCase {
  GetWinnerHouseUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Future<House> call() {
    return runSafetyFuture<House>(() async {
      final results = await _firestore
          .collection('houses')
          .orderBy('points', descending: true)
          .get();

      if (results.docs.isNotEmpty) {
        return House.fromJson(results.docs.first.data());
      }

      //TODO Gestire casata
    });
  }
}
