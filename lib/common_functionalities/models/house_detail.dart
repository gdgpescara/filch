import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'house_member.dart';

part 'house_detail.g.dart';

@JsonSerializable(createToJson: false)
class HouseDetail extends Equatable {
  const HouseDetail({
    required this.id,
    required this.points,
    required this.members,
  });

  factory HouseDetail.fromJson(Map<String, dynamic> json) => _$HouseDetailFromJson(json);

  final String id;
  final int points;
  final List<HouseMember> members;

  @override
  List<Object?> get props => [id, points, members];
}
