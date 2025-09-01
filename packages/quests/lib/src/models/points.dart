import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'points_type_enum.dart';

part 'points.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Points extends Equatable {
  const Points({required this.type, required this.points, required this.assignedBy, required this.assignedAt});

  factory Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);

  final PointsTypeEnum type;
  final int points;
  final String? assignedBy;
  @TimestampDateTimeConverter()
  @JsonKey(includeToJson: false)
  final DateTime assignedAt;

  Map<String, dynamic> toJson() => _$PointsToJson(this);

  @override
  List<Object?> get props => [type, points, assignedBy, assignedAt];
}
