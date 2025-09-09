import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'named_entity.dart';
import 'session.dart';

part 'grouped_sessions.g.dart';

/// Represents sessions grouped by day, then by start time, then by room
@JsonSerializable()
class GroupedSessions extends Equatable {
  const GroupedSessions({
    required this.sessionsByDay,
  });

  /// Creates a [GroupedSessions] from a JSON map
  factory GroupedSessions.fromJson(Map<String, dynamic> json) => _$GroupedSessionsFromJson(json);

  /// Converts this [GroupedSessions] to a JSON map
  Map<String, dynamic> toJson() => _$GroupedSessionsToJson(this);

  /// Sessions grouped by day (date as key), then by room name
  /// Key: Date as DateTime (only date part, time will be 00:00:00)
  /// Value: Map where key is room name (String) and value is list of sessions
  final Map<DateTime, Map<String, List<Session>>> sessionsByDay;

  /// Gets all available days sorted chronologically
  List<DateTime> get availableDays {
    final days = sessionsByDay.keys.toList()..sort();
    return days;
  }

  /// Gets sessions for a specific day grouped by room name
  Map<String, List<Session>>? getSessionsForDay(DateTime day) {
    final dayKey = DateTime(day.year, day.month, day.day);
    return sessionsByDay[dayKey];
  }

  /// Gets all sessions for a specific day and room
  List<Session> getSessionsForDayAndRoom(DateTime day, NamedEntity room) {
    final daySchedule = getSessionsForDay(day);
    if (daySchedule == null) return [];

    return daySchedule[room.name] ?? [];
  }

  /// Gets all available rooms for a specific day
  Set<NamedEntity> getRoomsForDay(DateTime day) {
    final daySchedule = getSessionsForDay(day);
    if (daySchedule == null) return {};

    // Get all unique rooms from the sessions
    final rooms = <NamedEntity>{};
    for (final sessions in daySchedule.values) {
      for (final session in sessions) {
        if (session.room != null) rooms.add(session.room!);
      }
    }
    return rooms;
  }

  /// Gets all start times for a specific day sorted chronologically
  List<DateTime> getStartTimesForDay(DateTime day) {
    final daySchedule = getSessionsForDay(day);
    if (daySchedule == null) return [];

    // Get all unique start times from all sessions
    final startTimes = <DateTime>{};
    for (final sessions in daySchedule.values) {
      for (final session in sessions) {
        startTimes.add(session.startsAt);
      }
    }

    final sortedTimes = startTimes.toList()..sort();
    return sortedTimes;
  }

  /// Gets sessions for a specific day and time
  List<Session> getSessionsForDayAndTime(DateTime day, DateTime time) {
    final daySchedule = getSessionsForDay(day);
    if (daySchedule == null) return [];

    // Find all sessions that start at the specified time
    final sessions = <Session>[];
    for (final roomSessions in daySchedule.values) {
      for (final session in roomSessions) {
        if (session.startsAt == time) {
          sessions.add(session);
        }
      }
    }

    return sessions;
  }

  /// Creates a copy of this [GroupedSessions] with the given fields replaced
  GroupedSessions copyWith({
    Map<DateTime, Map<String, List<Session>>>? sessionsByDay,
  }) {
    return GroupedSessions(
      sessionsByDay: sessionsByDay ?? this.sessionsByDay,
    );
  }

  @override
  List<Object?> get props => [sessionsByDay];
}
