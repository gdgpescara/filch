import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'day_sessions.dart';
import 'named_entity.dart';
import 'room_sessions.dart';

part 'grouped_sessions.g.dart';

@JsonSerializable(createToJson: false)
class GroupedSessions extends Equatable {
  const GroupedSessions({
    required this.daySessions,
  });

  factory GroupedSessions.fromJson(Map<String, dynamic> json) => _$GroupedSessionsFromJson(json);

  final List<DaySessions> daySessions;

  /// Gets all available days sorted chronologically
  List<DateTime> getAvailableDays({bool onlyFavorites = false}) {
    if (!onlyFavorites) {
      return daySessions.map((daySession) => daySession.day).toList()..sort();
    }

    return daySessions
        .where(
          (daySession) =>
              daySession.roomSessions.any((roomSession) => roomSession.sessions.any((session) => session.isFavorite)),
        )
        .map((daySession) => daySession.day)
        .toList()
      ..sort();
  }

  /// Gets sessions for a specific day grouped by room name
  List<RoomSessions> getSessionsForDay(DateTime day) {
    final dayKey = DateTime(day.year, day.month, day.day);
    final daySession = daySessions.firstWhereOrNull((ds) => ds.day == dayKey);

    if (daySession == null) {
      return [];
    }

    return daySession.roomSessions;
  }

  /// Gets all available rooms for a specific day
  Set<NamedEntity> getRoomsForDay(DateTime day) {
    final dayKey = DateTime(day.year, day.month, day.day);
    final daySession = daySessions.firstWhereOrNull((ds) => ds.day == dayKey);

    if (daySession == null) {
      return {};
    }

    return daySession.roomSessions.map((rs) => rs.room).toSet();
  }

  @override
  List<Object?> get props => [daySessions];
}
