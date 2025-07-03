import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignable_points.g.dart';

@JsonSerializable(createToJson: false)
class AssignablePoints extends Equatable {
  const AssignablePoints({required this.description, required this.points});

  factory AssignablePoints.fromJson(Map<String, dynamic> json) => _$AssignablePointsFromJson(json);

  final Map<String, String> description;
  final int points;

  @override
  List<Object?> get props => [description, points];
}
