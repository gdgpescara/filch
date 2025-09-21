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
    return snapshot.docs
        .map((doc) {
          try {
            final data = (doc.data() as Map<String, dynamic>?) ?? <String, dynamic>{};
            final json = <String, dynamic>{'id': doc.id}..addAll(data);
            return Session.fromJson(json);
          } catch (e) {
            logError('Failed to parse session ${doc.id}: $e', LogLevel.error, e, e is Error ? e.stackTrace : null);
            return null;
          }
        })
        .whereType<Session>()
        .toList();
  }

  GroupedSessions _groupSessions(List<Session> sessions) {
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
  }

  Stream<GroupedSessions> call() {
    return runSafetyStream(() {
      final favoritesStream = _getUserFavoriteSessionIdsUseCase();
      final sessionsStream = _firestore.collection('sessions').orderBy('startsAt', descending: false).snapshots();

      final controller = StreamController<GroupedSessions>();
      StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? sessionsSub;
      StreamSubscription<Set<String>>? favoritesSub;
      var favoriteIds = <String>{};
      QuerySnapshot? lastSessionsSnap;

      void emit() {
        if (lastSessionsSnap != null) {
          final sessions = _parseSessions(lastSessionsSnap!);
          final sessionsWithFavorites = sessions.map((s) => s.copyWith(isFavorite: favoriteIds.contains(s.id))).toList();
          final grouped = _groupSessions(sessionsWithFavorites);
          controller.add(grouped);
        }
      }

      favoritesSub = favoritesStream.listen((ids) {
        favoriteIds = ids;
        emit();
      });

      sessionsSub = sessionsStream.listen((snap) {
        lastSessionsSnap = snap;
        emit();
      });

      controller.onCancel = () {
        sessionsSub?.cancel();
        favoritesSub?.cancel();
      };

      return controller.stream;
    });
  }
}
