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
    if (!onlyFavorites) {
      return sessionsByDay.keys.toList()..sort();
    }

    return sessionsByDay.entries
        .where((entry) => entry.value.values.any((sessions) => sessions.any((session) => session.isFavorite)))
        .map((entry) => entry.key)
        .toList()
      ..sort();
  }

  /// Gets sessions for a specific day grouped by room name
  Map<String, List<Session>>? getSessionsForDay(DateTime day, {bool onlyFavorites = false}) {
    final dayKey = DateTime(day.year, day.month, day.day);
    final daySchedule = sessionsByDay[dayKey];
    if (daySchedule == null) return null;

    if (!onlyFavorites) return daySchedule;

    // Filter only favorite sessions
    final filteredSchedule = <String, List<Session>>{};
    
    for (final entry in daySchedule.entries) {
      final room = entry.key;
      final sessions = entry.value;
      final favoriteSessions = sessions.where((session) => session.isFavorite).toList();
      
      if (favoriteSessions.isNotEmpty) {
        filteredSchedule[room] = favoriteSessions;
      }
    }

    return filteredSchedule.isNotEmpty ? filteredSchedule : null;
  }

  /// Gets all available rooms for a specific day
  Set<NamedEntity> getRoomsForDay(DateTime day, {bool onlyFavorites = false}) {
    final daySchedule = getSessionsForDay(day, onlyFavorites: onlyFavorites);
    if (daySchedule == null) return <NamedEntity>{};

    // Get all unique rooms from the sessions using expand for better performance
    return daySchedule.values
        .expand((sessions) => sessions.where((session) => session.room != null).map((session) => session.room!))
        .toSet();
  }

  @override
  List<Object?> get props => [sessionsByDay];
}
