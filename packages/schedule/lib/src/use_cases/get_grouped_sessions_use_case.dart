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
                return null;
              }
            })
            .whereType<Session>()
            .toList();

        // Group by day first
        final sessionsByDay = sessions
            .groupListsBy(
              (session) => DateTime(
                session.startsAt.year,
                session.startsAt.month,
                session.startsAt.day,
              ),
            )
            .map((day, sessions) {
              final sessionsByRoomName = sessions.groupListsBy((session) => session.room.name);
              return MapEntry(day, sessionsByRoomName);
            });

        return GroupedSessions(sessionsByDay: sessionsByDay);
      });
    });
  }
}
