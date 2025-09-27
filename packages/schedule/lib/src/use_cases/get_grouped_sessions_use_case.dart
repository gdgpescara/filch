import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/grouped_sessions.dart';
import '../models/session.dart';
import 'get_user_favorite_session_ids_use_case.dart';

@lazySingleton
class GetGroupedSessionsUseCase {
  GetGroupedSessionsUseCase(
    this._firestore,
    this._getUserFavoriteSessionIdsUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetUserFavoriteSessionIdsUseCase _getUserFavoriteSessionIdsUseCase;

  List<Session> _parseSessions(QuerySnapshot snapshot) {
    final sessions = <Session>[];

    for (final doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
        final session = Session.fromJson({
          'id': doc.id,
          ...data,
        });
        sessions.add(session);
      } catch (e, stackTrace) {
        logError(
          'Failed to parse session ${doc.id}: $e',
          LogLevel.error,
          e,
          stackTrace,
        );
        // Continue processing other sessions instead of failing completely
      }
    }

    return sessions;
  }

  GroupedSessions _groupSessions(List<Session> sessions) {
    // Group sessions by day (normalize to start of day)
    final sessionsByDay = sessions.groupListsBy(_normalizeToDay);

    // Transform each day's sessions into room-grouped structure
    final processedSessionsByDay = sessionsByDay.map((day, daySessions) {
      return MapEntry(day, _groupSessionsByRoom(daySessions));
    });

    return GroupedSessions(sessionsByDay: processedSessionsByDay);
  }

  /// Normalizes a session's start time to the beginning of the day
  DateTime _normalizeToDay(Session session) {
    final startTime = session.startsAt;
    return DateTime(startTime.year, startTime.month, startTime.day);
  }

  /// Groups sessions by room and adds service sessions to each room
  Map<String, List<Session>> _groupSessionsByRoom(List<Session> sessions) {
    final serviceSessions = <Session>[];
    final regularSessions = <Session>[];

    // Separate service and regular sessions in a single pass
    for (final session in sessions) {
      if (session.isServiceSession) {
        serviceSessions.add(session);
      } else {
        regularSessions.add(session);
      }
    }

    // Group regular sessions by room
    final sessionsByRoom = regularSessions.groupListsBy(
      (session) => session.room?.name ?? 'Unknown Room',
    );

    // Add service sessions to each room and sort by start time
    for (final roomSessions in sessionsByRoom.values) {
      roomSessions
        ..addAll(serviceSessions)
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    }
    
    return sessionsByRoom;
  }

  Stream<GroupedSessions> call() {
    return runSafetyStream(() {
      late StreamController<GroupedSessions> controller;
      StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? sessionsSub;
      StreamSubscription<Set<String>>? favoritesSub;
      
      var favoriteIds = <String>{};
      QuerySnapshot<Map<String, dynamic>>? latestSnapshot;

      void emitGroupedSessions() {
        final snapshot = latestSnapshot;
        if (snapshot == null) return;
        
        try {
          final sessions = _parseSessions(snapshot);
          final sessionsWithFavorites = _applyFavoriteStatus(sessions, favoriteIds);
          final grouped = _groupSessions(sessionsWithFavorites);
          controller.add(grouped);
        } catch (error) {
          controller.addError(error);
        }
      }

      void handleError(Object error) {
        controller.addError(error);
      }

      controller = StreamController<GroupedSessions>(
        onListen: () {
          favoritesSub = _getUserFavoriteSessionIdsUseCase().listen(
            (ids) {
              favoriteIds = ids;
              emitGroupedSessions();
            },
            onError: handleError,
          );

          sessionsSub = _firestore.collection('sessions').orderBy('startsAt').snapshots().listen(
            (snapshot) {
              latestSnapshot = snapshot;
              emitGroupedSessions();
            },
            onError: handleError,
          );
        },
        onCancel: () {
          sessionsSub?.cancel();
          favoritesSub?.cancel();
        },
      );

      return controller.stream;
    });
  }

  /// Applies favorite status to sessions efficiently
  List<Session> _applyFavoriteStatus(List<Session> sessions, Set<String> favoriteIds) {
    if (favoriteIds.isEmpty) return sessions;

    return sessions.map((session) {
      final isFavorite = favoriteIds.contains(session.id);
      return session.isFavorite != isFavorite ? session.copyWith(isFavorite: isFavorite) : session;
    }).toList();
  }
}
