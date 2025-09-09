import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/session.dart';

@lazySingleton
class GetUserFavoriteSessionsUseCase {
  GetUserFavoriteSessionsUseCase(
    this._firestore,
    this._getSignedUserUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetSignedUserUseCase _getSignedUserUseCase;

  /// Returns a stream of favorite sessions grouped by day for the current user
  ///
  /// The stream will emit an empty map if the user is not signed in
  /// The stream will update automatically when favorites are added/removed
  Stream<Map<DateTime, List<Session>>> call() {
    return runSafetyStream(() {
      final user = _getSignedUserUseCase();
      if (user == null) {
        // Return empty stream if user is not signed in
        return Stream.value({});
      }

      return _firestore.collection('users').doc(user.uid).collection('favorite_sessions').snapshots().asyncMap((snapshot) async {
        // Get favorite session IDs
        final favoriteSessionIds = snapshot.docs
            .map((doc) => doc.data()['sessionId'] as String?)
            .where((sessionId) => sessionId != null)
            .cast<String>()
            .toList();

        if (favoriteSessionIds.isEmpty) {
          return <DateTime, List<Session>>{};
        }

        // Fetch all favorite sessions in parallel
        final sessionFutures = favoriteSessionIds.map((sessionId) async {
          try {
            final sessionDoc = await _firestore.collection('sessions').doc(sessionId).get();

            if (sessionDoc.exists && sessionDoc.data() != null) {
              return Session.fromJson({
                'id': sessionDoc.id,
                ...sessionDoc.data()!,
              });
            }
          } catch (e) {
            // Skip sessions that can't be parsed
          }
          return null;
        });

        final sessions = (await Future.wait(sessionFutures)).whereType<Session>().toList();

        // Group sessions by day
        final sessionsByDay = sessions
            .groupListsBy(
              (session) => DateTime(
                session.startsAt.year,
                session.startsAt.month,
                session.startsAt.day,
              ),
            )
            .map((day, sessions) {
              // Sort sessions by start time within each day
              final sortedSessions = sessions.toList()..sort((a, b) => a.startsAt.compareTo(b.startsAt));
              return MapEntry(day, sortedSessions);
            });

        return sessionsByDay;
      });
    });
  }
}
