import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'session.dart';

part 'grouped_sessions.g.dart';

/// Represents sessions grouped by day and then by start time
@JsonSerializable()
class GroupedSessions extends Equatable {
  const GroupedSessions({
    required this.sessionsByDay,
  });

  /// Creates a [GroupedSessions] from a JSON map
  factory GroupedSessions.fromJson(Map<String, dynamic> json) => _$GroupedSessionsFromJson(json);

  /// Converts this [GroupedSessions] to a JSON map
  Map<String, dynamic> toJson() => _$GroupedSessionsToJson(this);

  /// Sessions grouped by day (date as key) and then by start time
  /// Key: Date as DateTime (only date part, time will be 00:00:00)
  /// Value: Map where key is start time (DateTime) and value is list of sessions
  final Map<DateTime, Map<DateTime, List<Session>>> sessionsByDay;

  /// Gets all available days sorted chronologically
  List<DateTime> get availableDays {
    final days = sessionsByDay.keys.toList()
    ..sort();
    return days;
  }

  /// Gets sessions for a specific day
  Map<DateTime, List<Session>>? getSessionsForDay(DateTime day) {
    return sessionsByDay[day];
  }

  /// Gets all start times for a specific day, sorted chronologically
  List<DateTime> getStartTimesForDay(DateTime day) {
    final dayTimetable = sessionsByDay[day];
    if (dayTimetable == null) return [];
    
    final startTimes = dayTimetable.keys.toList()
    ..sort();
    return startTimes;
  }

  /// Gets sessions for a specific day and start time
  List<Session> getSessionsForDayAndTime(DateTime day, DateTime startTime) {
    return sessionsByDay[day]?[startTime] ?? [];
  }

  /// Creates a copy of this [GroupedSessions] with the given fields replaced
  GroupedSessions copyWith({
    Map<DateTime, Map<DateTime, List<Session>>>? sessionsByDay,
  }) {
    return GroupedSessions(
      sessionsByDay: sessionsByDay ?? this.sessionsByDay,
    );
  }

  @override
  List<Object?> get props => [sessionsByDay];
}
