import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_delay.g.dart';

/// Represents a room delay stored in Firestore
/// Document ID can be 'global' for conference-wide delays or room ID for room-specific delays
@JsonSerializable(createToJson: false)
class RoomDelay extends Equatable {
  const RoomDelay({
    required this.id,
    required this.delay,
    required this.updatedBy,
    required this.updatedAt,
  });

  /// Creates a [RoomDelay] from a JSON map
  factory RoomDelay.fromJson(Map<String, dynamic> json) => _$RoomDelayFromJson(json);

  /// ID of the delay document (not stored in the document itself)
  /// Use 'global' for conference-wide delays or room ID for room-specific delays
  @JsonKey(includeToJson: false)
  final String id;

  /// Delay duration in minutes
  final int delay;

  /// User ID who updated this delay
  final String updatedBy;

  /// Timestamp when this delay was last updated
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime updatedAt;

  /// Creates a copy of this [RoomDelay] with the given fields replaced
  RoomDelay copyWith({
    String? id,
    int? delay,
    String? updatedBy,
    DateTime? updatedAt,
  }) {
    return RoomDelay(
      id: id ?? this.id,
      delay: delay ?? this.delay,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static DateTime _timestampFromJson(Timestamp timestamp) => timestamp.toDate();

  static Timestamp _timestampToJson(DateTime dateTime) => Timestamp.fromDate(dateTime);

  @override
  List<Object?> get props => [id, delay, updatedBy, updatedAt];
}
