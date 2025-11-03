import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(createToJson: false)
class Team extends Equatable {
  const Team({
    required this.id,
    required this.name,
    required this.claim,
    required this.description,
    required this.membersCount,
    required this.imageUrl,
    required this.profileImageUrl,
    required this.assignable,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final String id;
  final Map<String, String> name;
  final Map<String, String> claim;
  final Map<String, String> description;
  final int membersCount;
  final String imageUrl;
  final String profileImageUrl;
  final bool assignable;

  @override
  List<Object?> get props => [id, name, claim, description, membersCount, imageUrl, profileImageUrl, assignable];
}
