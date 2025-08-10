import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

/// Represents a conference room
@JsonSerializable()
class Room extends Equatable {
  const Room({
    required this.id,
    required this.name,
  });

  /// Creates a [Room] from a JSON map
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Converts this [Room] to a JSON map
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  /// Unique identifier for the room
  final int id;

  /// Name of the room
  final String name;

  /// Creates a copy of this [Room] with the given fields replaced
  Room copyWith({
    int? id,
    String? name,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
