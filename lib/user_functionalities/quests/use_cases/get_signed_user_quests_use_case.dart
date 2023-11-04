import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/error_catcher.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../models/quest.dart';

@lazySingleton
class GetSignedUserQuestsUseCase {
  GetSignedUserQuestsUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  Stream<List<Quest>> call() {
    return runSafetyStream(() {
      return _firestore
          .collection('quests')
          .where('actor', isEqualTo: _getSignedUserUseCase()?.uid)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => Quest.fromJson({'id': doc.id, ...doc.data()})).toList());
    });
  }
}
