import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../schedule.dart';
import 'get_max_room_delay_use_case.dart';

@lazySingleton
class GetGroupedSessionsUseCase {
  GetGroupedSessionsUseCase(
    this._firestore,
    this._getUserFavoriteSessionIdsUseCase,
    this._getMaxRoomDelayUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetUserFavoriteSessionIdsUseCase _getUserFavoriteSessionIdsUseCase;
  final GetMaxRoomDelayUseCase _getMaxRoomDelayUseCase;

  Stream<GroupedSessions> call() {
    return runSafetyStream(() {
      return Rx.combineLatest3(
        _firestore.collection('sessions').snapshots(),
        _getUserFavoriteSessionIdsUseCase(),
        _getMaxRoomDelayUseCase(),
        (snapshot, favoriteIds, maxDelay) {
          final sessions = _parseSessions(snapshot, favoriteIds, maxDelay);
          return _groupSessions(sessions, maxDelay);
        },
      );
    });
  }

  List<Session> _parseSessions(QuerySnapshot snapshot, Set<String> favoriteIds, int maxDelays) {
    final sessions = <Session>[];

    for (final doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
        final session = Session.fromJson({
          'id': doc.id,
          ...data,
          'realStartsAt': data['startsAt'],
          'realEndsAt': data['endsAt'],
        });
        sessions.add(
          session.copyWith(
            isFavorite: favoriteIds.contains(session.id),
            realStartsAt: session.startsAt.add(Duration(minutes: maxDelays)),
            realEndsAt: session.endsAt.add(Duration(minutes: maxDelays)),
          ),
        );
      } catch (e, stackTrace) {
        logError(
          'Failed to parse session ${doc.id}: $e',
          LogLevel.error,
          e,
          stackTrace,
        );
      }
    }

    return sessions;
  }

  GroupedSessions _groupSessions(List<Session> sessions, int maxDelay) {
    final daySessions = sessions.groupListsBy(_normalizeToDay).entries.map((entry) {
      final day = entry.key;
      final daySessions = entry.value;
      final roomSessions = _groupSessionsByRoom(daySessions, maxDelay);
      return DaySessions(day: day, roomSessions: roomSessions);
    });

    return GroupedSessions(daySessions: daySessions.toList());
  }

  DateTime _normalizeToDay(Session session) {
    final startTime = session.startsAt;
    return DateTime(startTime.year, startTime.month, startTime.day);
  }

  List<RoomSessions> _groupSessionsByRoom(List<Session> sessions, int maxDelay) {
    final serviceSessions = <Session>[];
    final roomDataMap = <String, ({List<Session> all, List<Session> favorites})>{};

    for (final session in sessions) {
      if (session.isServiceSession) {
        serviceSessions.add(session);
        continue;
      }

      final roomName = session.room?.name ?? 'Unknown Room';
      final roomData = roomDataMap.putIfAbsent(roomName, () => (all: <Session>[], favorites: <Session>[]));

      roomData.all.add(session);
      if (session.isFavorite) {
        roomData.favorites.add(session);
      }
    }

    return roomDataMap.entries.map((entry) {
      final roomName = entry.key;
      final roomData = entry.value;
      final allSessions = [...roomData.all, ...serviceSessions]..sort((a, b) => a.startsAt.compareTo(b.startsAt));
      final allFavorites = [...roomData.favorites, ...serviceSessions]..sort((a, b) => a.startsAt.compareTo(b.startsAt));

      return RoomSessions(
        room: NamedEntity(id: roomName.hashCode, name: roomName),
        sessions: allSessions,
        favoriteSessions: allFavorites,
        scheduleDelay: maxDelay,
      );
    }).toList();
  }
}
