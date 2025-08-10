import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_format.g.dart';

/// Represents the format/type of a session
@JsonSerializable()
class SessionFormat extends Equatable {
  const SessionFormat({
    required this.id,
    required this.name,
  });

  /// Creates a [SessionFormat] from a JSON map
  factory SessionFormat.fromJson(Map<String, dynamic> json) => _$SessionFormatFromJson(json);

  /// Converts this [SessionFormat] to a JSON map
  Map<String, dynamic> toJson() => _$SessionFormatToJson(this);

  /// Unique identifier for the session format
  final int id;

  /// Name of the session format (e.g., "Keynote", "Session", "Workshop")
  final String name;

  /// Creates a copy of this [SessionFormat] with the given fields replaced
  SessionFormat copyWith({
    int? id,
    String? name,
  }) {
    return SessionFormat(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
