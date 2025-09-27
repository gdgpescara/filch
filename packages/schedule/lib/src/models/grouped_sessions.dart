import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'named_entity.dart';
import 'session.dart';

part 'grouped_sessions.g.dart';

/// Represents sessions grouped by day, then by start time, then by room
@JsonSerializable(createToJson: false)
class GroupedSessions extends Equatable {
  const GroupedSessions({
    required this.sessionsByDay,
  });

  /// Creates a [GroupedSessions] from a JSON map
  factory GroupedSessions.fromJson(Map<String, dynamic> json) => _$GroupedSessionsFromJson(json);

  /// Sessions grouped by day (date as key), then by room name
  /// Key: Date as DateTime (only date part, time will be 00:00:00)
  /// Value: Map where key is room name (String) and value is list of sessions
  final Map<DateTime, Map<String, List<Session>>> sessionsByDay;

  /// Gets all available days sorted chronologically
  List<DateTime> getAvailableDays({bool onlyFavorites = false}) {
    final days = sessionsByDay.keys.where((day) {
      if (!onlyFavorites) return true;
      final daySchedule = sessionsByDay[day];
      if (daySchedule == null) return false;
      return daySchedule.values.any((sessions) => sessions.any((session) => session.isFavorite));
    }).toList()..sort();
    return days;
  }

  /// Gets sessions for a specific day grouped by room name
  Map<String, List<Session>>? getSessionsForDay(DateTime day, {bool onlyFavorites = false}) {
    final dayKey = DateTime(day.year, day.month, day.day);
    final daySchedule = sessionsByDay[dayKey];
    if (daySchedule == null) return null;

    if (!onlyFavorites) return daySchedule;

    // Filter only favorite sessions
    final filteredSchedule = <String, List<Session>>{};
    daySchedule.forEach((room, sessions) {
      final favoriteSessions = sessions.where((session) => session.isFavorite).toList();
      if (favoriteSessions.isNotEmpty) {
        filteredSchedule[room] = favoriteSessions;
      }
    });
    return filteredSchedule.isEmpty ? null : filteredSchedule;
  }

  /// Gets all available rooms for a specific day
  Set<NamedEntity> getRoomsForDay(DateTime day, {bool onlyFavorites = false}) {
    final daySchedule = getSessionsForDay(day, onlyFavorites: onlyFavorites);
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

  @override
  List<Object?> get props => [sessionsByDay];
}
