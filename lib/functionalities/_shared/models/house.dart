import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class House extends Equatable {
  const House({
    required this.id,
    required this.members,
    required this.points,
  });

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  final String id;
  final int members;
  final int points;

  Map<String, dynamic> toJson() => _$HouseToJson(this);

  @override
  List<Object?> get props => [id, members, points];
}
