import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'named_entity.dart';
import 'speaker.dart';

part 'session.g.dart';

/// Represents a conference session
@JsonSerializable(createToJson: false)
class Session extends Equatable {
  const Session({
    required this.id,
    required this.title,
    this.description,
    required this.startsAt,
    required this.endsAt,
    required this.realStartsAt,
    required this.realEndsAt,
    required this.speakers,
    this.room,
    this.sessionFormat,
    required this.tracks,
    required this.tags,
    this.level,
    this.language,
    this.isFavorite = false,
    this.isServiceSession = false,
  });

  /// Creates a [Session] from a JSON map
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  /// Unique identifier for the session
  final String id;

  /// Title of the session
  final String title;

  /// Description of the session
  final String? description;

  /// Start time of the session in ISO 8601 format
  final DateTime startsAt;

  /// End time of the session in ISO 8601 format
  final DateTime endsAt;

  /// Actual start time of the session (considering delays)
  final DateTime realStartsAt;

  /// Actual end time of the session (considering delays)
  final DateTime realEndsAt;

  /// List of speakers for this session
  final List<Speaker> speakers;

  /// Room where the session takes place
  final NamedEntity? room;

  /// Format/type of the session
  final NamedEntity? sessionFormat;

  /// List of tracks/categories this session belongs to
  final List<NamedEntity> tracks;

  /// List of tags for this session
  final List<NamedEntity> tags;

  /// Difficulty level of the session
  final NamedEntity? level;

  /// Language of the session
  final NamedEntity? language;

  /// Whether this session is marked as favorite by the current user
  final bool isFavorite;

  /// Whether this session is a service session (e.g., registration, coffee break, etc.)
  final bool isServiceSession;

  /// Creates a copy of this [Session] with the given fields replaced
  Session copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? realStartsAt,
    DateTime? realEndsAt,
    List<Speaker>? speakers,
    NamedEntity? room,
    NamedEntity? sessionFormat,
    List<NamedEntity>? tracks,
    List<NamedEntity>? tags,
    NamedEntity? level,
    NamedEntity? language,
    bool? isFavorite,
    bool? isServiceSession,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      realStartsAt: realStartsAt ?? this.realStartsAt,
      realEndsAt: realEndsAt ?? this.realEndsAt,
      speakers: speakers ?? this.speakers,
      room: room ?? this.room,
      sessionFormat: sessionFormat ?? this.sessionFormat,
      tracks: tracks ?? this.tracks,
      tags: tags ?? this.tags,
      level: level ?? this.level,
      language: language ?? this.language,
      isFavorite: isFavorite ?? this.isFavorite,
      isServiceSession: isServiceSession ?? this.isServiceSession,
    );
  }

  /// Duration of the session
  Duration get duration => endsAt.difference(startsAt);

  /// Duration of the session in minutes
  int get durationInMinutes => duration.inMinutes;

  /// Checks if the session is currently running
  bool get isCurrentlyRunning {
    final now = DateTime.now();
    return now.isAfter(realStartsAt) && now.isBefore(realEndsAt);
  }

  /// Checks if the session is ended
  bool get isEnded {
    return DateTime.now().isAfter(realEndsAt);
  }

  /// Checks if the session is upcoming
  bool get isUpcoming {
    return DateTime.now().isBefore(realStartsAt);
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    startsAt,
    endsAt,
    realStartsAt,
    realEndsAt,
    speakers,
    room,
    sessionFormat,
    tracks,
    tags,
    level,
    language,
    isFavorite,
    isServiceSession,
  ];
}
