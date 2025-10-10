import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/loading_sentences.dart';

@lazySingleton
class GetLoadingSentencesUseCase {
  GetLoadingSentencesUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<LoadingSentences> call() {
    return runSafetyStream(() async* {
      yield* _firestore.collection('configurations').doc('loading_sentences').snapshots().map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return const LoadingSentences(sentences: []);
        }
        return LoadingSentences.fromJson(snapshot.data()!);
      });
    });
  }
}
