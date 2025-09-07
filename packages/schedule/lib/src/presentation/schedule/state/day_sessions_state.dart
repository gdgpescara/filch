import 'package:equatable/equatable.dart';
import '../../../models/models.dart';

class DaySessionsState extends Equatable {
  const DaySessionsState({
    required this.sessions,
    required this.filteredSessions,
  });

  final Map<String, List<Session>> sessions;
  final List<Session> filteredSessions;

  @override
  List<Object?> get props => [sessions, filteredSessions];

  DaySessionsState copyWith({
    Map<String, List<Session>>? sessions,
    List<Session>? filteredSessions,
  }) {
    return DaySessionsState(
      sessions: sessions ?? this.sessions,
      filteredSessions: filteredSessions ?? this.filteredSessions,
    );
  }
}
