import 'package:catch_and_flow/catch_and_flow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsBeforeDevFestUseCase {
  IsBeforeDevFestUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<bool> call() {
    return runSafetyStream(() {
      return _firestore.collection('configurations').doc('feature_flags').snapshots().map((event) {
        final data = event.data() ?? {};
        return data['beforeDevFest'] as bool? ?? false;
      });
    });
  }
}
