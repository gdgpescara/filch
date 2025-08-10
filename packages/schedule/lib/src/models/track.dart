import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

/// Represents a track/category for a session
@JsonSerializable()
class Track extends Equatable {
  const Track({
    required this.id,
    required this.name,
  });

  /// Creates a [Track] from a JSON map
  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  /// Converts this [Track] to a JSON map
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  /// Unique identifier for the track
  final int id;

  /// Name of the track (e.g., "Technical", "Keynote", "Workshop")
  final String name;

  /// Creates a copy of this [Track] with the given fields replaced
  Track copyWith({
    int? id,
    String? name,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
