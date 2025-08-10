import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'language.dart';
import 'level.dart';
import 'room.dart';
import 'session_format.dart';
import 'speaker.dart';
import 'track.dart';

part 'session.g.dart';

/// Represents a conference session
@JsonSerializable()
class Session extends Equatable {
  const Session({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.speakers,
    required this.room,
    required this.sessionFormat,
    required this.tracks,
    required this.level,
    required this.language,
  });

  /// Creates a [Session] from a JSON map
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  /// Converts this [Session] to a JSON map
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  /// Unique identifier for the session
  final String id;

  /// Title of the session
  final String title;

  /// Description of the session
  final String description;

  /// Start time of the session in ISO 8601 format
  final DateTime startsAt;

  /// End time of the session in ISO 8601 format
  final DateTime endsAt;

  /// List of speakers for this session
  final List<Speaker> speakers;

  /// Room where the session takes place
  final Room room;

  /// Format/type of the session
  final SessionFormat sessionFormat;

  /// List of tracks/categories this session belongs to
  final List<Track> tracks;

  /// Difficulty level of the session
  final Level level;

  /// Language of the session
  final Language language;

  /// Creates a copy of this [Session] with the given fields replaced
  Session copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startsAt,
    DateTime? endsAt,
    List<Speaker>? speakers,
    Room? room,
    SessionFormat? sessionFormat,
    List<Track>? tracks,
    Level? level,
    Language? language,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      speakers: speakers ?? this.speakers,
      room: room ?? this.room,
      sessionFormat: sessionFormat ?? this.sessionFormat,
      tracks: tracks ?? this.tracks,
      level: level ?? this.level,
      language: language ?? this.language,
    );
  }

  /// Duration of the session
  Duration get duration => endsAt.difference(startsAt);

  /// Checks if the session is currently running
  bool get isCurrentlyRunning {
    final now = DateTime.now();
    return now.isAfter(startsAt) && now.isBefore(endsAt);
  }

  /// Checks if the session has ended
  bool get hasEnded {
    return DateTime.now().isAfter(endsAt);
  }

  /// Checks if the session is upcoming
  bool get isUpcoming {
    return DateTime.now().isBefore(startsAt);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startsAt,
        endsAt,
        speakers,
        room,
        sessionFormat,
        tracks,
        level,
        language,
      ];
}
