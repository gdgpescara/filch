import 'package:equatable/equatable.dart';
import '../../../models/models.dart';

class DaySessionsState extends Equatable {
  const DaySessionsState({
    required this.daySessions,
    this.selectedRoomSessions,
  });

  final List<RoomSessions> daySessions;
  final RoomSessions? selectedRoomSessions;

  @override
  List<Object?> get props => [daySessions, selectedRoomSessions];

  DaySessionsState copyWith({
    List<RoomSessions>? daySessions,
    RoomSessions? selectedRoomSessions,
  }) {
    return DaySessionsState(
      daySessions: daySessions ?? this.daySessions,
      selectedRoomSessions: selectedRoomSessions ?? this.selectedRoomSessions,
    );
  }
}
