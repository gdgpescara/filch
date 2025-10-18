import 'package:catch_and_flow/catch_and_flow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFeatureFlagsUseCase {
  GetFeatureFlagsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<Map<String, bool>> call() {
    return runSafetyStream(() {
      return _firestore.collection('configurations').doc('feature_flags').snapshots().map((event) {
        final data = event.data() ?? {};
        return data.map((key, value) => MapEntry(key, value as bool));
      });
    });
  }
}
