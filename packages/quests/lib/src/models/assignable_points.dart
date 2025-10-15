
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../quests.dart';

part 'assignable_points.g.dart';

@JsonSerializable(createToJson: false)
class AssignablePoints extends Equatable {
  const AssignablePoints({required this.description, required this.points, required this.type, required this.assigner});

  factory AssignablePoints.fromJson(Map<String, dynamic> json) => _$AssignablePointsFromJson(json);

  final Map<String, String> description;
  final double points;
  final AssignablePointsTypeEnum type;
  final PointAssigner assigner;

  @override
  List<Object?> get props => [description, points, type, assigner];
}
