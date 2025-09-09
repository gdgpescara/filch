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
      return _firestore.collection('sessions').orderBy('startsAt', descending: false).snapshots().map((snapshot) {
        final sessions = snapshot.docs
            .map((doc) {
              try {
                return Session.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                });
              } catch (e) {
                logError('Failed to parse session ${doc.id}: $e', LogLevel.error, e, e is Error ? e.stackTrace : null);
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
            .map((day, sessions) {
              final serviceSessions = sessions.where((s) => s.isServiceSession).toList();
              final otherSessions = sessions.where((s) => !s.isServiceSession).toList();
              final sessionsByRoomName = otherSessions.groupListsBy((session) => session.room!.name);
              for (final entry in sessionsByRoomName.entries) {
                entry.value
                  ..addAll(serviceSessions)
                  ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
              }
              return MapEntry(day, sessionsByRoomName);
            });

        return GroupedSessions(sessionsByDay: sessionsByDay);
      });
    });
  }
}
