import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'room_sessions.dart';

part 'day_sessions.g.dart';

@JsonSerializable(createToJson: false)
class DaySessions extends Equatable {
  const DaySessions({
    required this.day,
    required this.roomSessions,
  });

  factory DaySessions.fromJson(Map<String, dynamic> json) => _$DaySessionsFromJson(json);

  final DateTime day;
  final List<RoomSessions> roomSessions;

  @override
  List<Object?> get props => [day, roomSessions];
}
