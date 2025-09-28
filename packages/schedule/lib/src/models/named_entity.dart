import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'named_entity.g.dart';

/// Represents a generic entity with id and name
/// Used for Track, Room, SessionFormat, Level, Language, etc.
@JsonSerializable(createToJson: false)
class NamedEntity extends Equatable {
  const NamedEntity({
    required this.id,
    required this.name,
  });

  /// Creates a [NamedEntity] from a JSON map
  factory NamedEntity.fromJson(Map<String, dynamic> json) => _$NamedEntityFromJson(json);

  /// Unique identifier for the entity
  final int id;

  /// Name of the entity
  final String name;

  /// Creates a copy of this [NamedEntity] with the given fields replaced
  NamedEntity copyWith({
    int? id,
    String? name,
  }) {
    return NamedEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
