import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../error_handling/error_catcher.dart';

@lazySingleton
class GetFeatureFlagsUseCase {
  GetFeatureFlagsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Future<Map<String, bool>> call() {
    return runSafetyFuture(() async {
      final config = await _firestore.collection('configurations').doc('feature_flags').get();
      return config.data()!.map((key, value) => MapEntry(key, value as bool));
    });
  }
}
