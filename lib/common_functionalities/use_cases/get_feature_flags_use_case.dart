import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../error_handling/error_catcher.dart';

@lazySingleton
class GetFeatureFlagsUseCase {
  GetFeatureFlagsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<Map<String, bool>> call() {
    return runSafetyStream(() {
      return _firestore
          .collection('configurations')
          .doc('feature_flags')
          .snapshots()
          .map((event) => event.data()!.map((key, value) => MapEntry(key, value as bool)));
    });
  }
}
