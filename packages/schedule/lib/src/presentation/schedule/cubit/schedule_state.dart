import 'package:equatable/equatable.dart';

import '../../../models/session.dart';

/// Base class for all schedule states
abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

/// Initial state when schedule hasn't been loaded yet
class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

/// State when schedule is being loaded
class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

/// State when schedule has been loaded successfully
class ScheduleLoaded extends ScheduleState {
  const ScheduleLoaded({
    required this.sessionsByDay,
    required this.bookmarkedSessions,
  });

  final Map<DateTime, Map<DateTime, List<Session>>> sessionsByDay;
  final Set<String> bookmarkedSessions;

  @override
  List<Object?> get props => [sessionsByDay, bookmarkedSessions];

  ScheduleLoaded copyWith({
    Map<DateTime, Map<DateTime, List<Session>>>? sessionsByDay,
    Set<String>? bookmarkedSessions,
  }) {
    return ScheduleLoaded(
      sessionsByDay: sessionsByDay ?? this.sessionsByDay,
      bookmarkedSessions: bookmarkedSessions ?? this.bookmarkedSessions,
    );
  }
}

/// State when there's an error loading the schedule
class ScheduleError extends ScheduleState {
  const ScheduleError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
