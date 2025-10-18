import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'named_entity.dart';
import 'session.dart';

part 'room_sessions.g.dart';

@JsonSerializable(createToJson: false)
class RoomSessions extends Equatable {
  const RoomSessions({
    required this.room,
    required this.sessions,
    this.favoriteSessions = const [],
    this.scheduleDelay = 0,
  });

  factory RoomSessions.fromJson(Map<String, dynamic> json) => _$RoomSessionsFromJson(json);

  final NamedEntity room;
  final List<Session> sessions;
  final List<Session> favoriteSessions;
  final int scheduleDelay;

  @override
  List<Object?> get props => [room, sessions, favoriteSessions, scheduleDelay];
}
