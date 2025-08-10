import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'level.g.dart';

/// Represents the difficulty level of a session
@JsonSerializable()
class Level extends Equatable {
  const Level({
    required this.id,
    required this.name,
  });

  /// Creates a [Level] from a JSON map
  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  /// Converts this [Level] to a JSON map
  Map<String, dynamic> toJson() => _$LevelToJson(this);

  /// Unique identifier for the level
  final int id;

  /// Name of the level (e.g., "Beginner", "Intermediate", "Advanced")
  final String name;

  /// Creates a copy of this [Level] with the given fields replaced
  Level copyWith({
    int? id,
    String? name,
  }) {
    return Level(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
