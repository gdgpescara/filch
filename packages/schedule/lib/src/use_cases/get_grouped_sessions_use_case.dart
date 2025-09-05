import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/grouped_sessions.dart';
import '../models/session.dart';

@lazySingleton
class GetGroupedSessionsUseCase {
  GetGroupedSessionsUseCase(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<GroupedSessions> call() {
    return runSafetyStream(() {
      return _firestore.collection('sessions').snapshots().map((snapshot) {
        final sessions = snapshot.docs
            .map((doc) {
              try {
                return Session.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                });
              } catch (e) {
                // Skip invalid sessions
                return null;
              }
            })
            .whereType<Session>()
            .toList();

        final sessionsByDay = sessions
            .groupListsBy(
              (session) => DateTime(
                session.startsAt.year,
                session.startsAt.month,
                session.startsAt.day,
              ),
            )
            .map(
              (day, sessionsForDay) => MapEntry(
                day,
                sessionsForDay
                    .groupListsBy((session) => session.startsAt)
                    .map(
                      (startTime, sessionsAtTime) => MapEntry(
                        startTime,
                        sessionsAtTime..sort((a, b) => a.room.name.compareTo(b.room.name)),
                      ),
                    ),
              ),
            );

        return GroupedSessions(sessionsByDay: sessionsByDay);
      });
    });
  }
}
