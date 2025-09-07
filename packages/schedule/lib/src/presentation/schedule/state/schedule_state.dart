import 'package:equatable/equatable.dart';

import '../../../models/grouped_sessions.dart';

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
    required this.groupedSessions,
  });

  final GroupedSessions groupedSessions;

  @override
  List<Object?> get props => [groupedSessions];

  ScheduleLoaded copyWith({
    GroupedSessions? groupedSessions,
  }) {
    return ScheduleLoaded(
      groupedSessions: groupedSessions ?? this.groupedSessions,
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
