import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house_member.g.dart';

@JsonSerializable(createToJson: false)
class HouseMember extends Equatable {
  const HouseMember({
    required this.email,
    this.displayName,
    this.points,
  });

  factory HouseMember.fromJson(Map<String, dynamic> json) => _$HouseMemberFromJson(json);

  final String email;
  final String? displayName;
  final int? points;

  @override
  List<Object?> get props => [email, displayName, points];
}
