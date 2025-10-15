import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(createToJson: false)
class Team extends Equatable {
  const Team({
    required this.id,
    required this.name,
    required this.claim,
    required this.membersCount,
    required this.imageUrl,
    required this.assignable,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final String id;
  final String name;
  final Map<String, String> claim;
  final int membersCount;
  final String imageUrl;
  final bool assignable;

  @override
  List<Object?> get props => [id, name, claim, membersCount, imageUrl, assignable];
}
