import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ranking_item.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RankingItem extends Equatable {
  const RankingItem({required this.uid, this.displayName, this.photoUrl, required this.email, this.points = 0});

  factory RankingItem.fromJson(Map<String, dynamic> json) => _$RankingItemFromJson(json);

  final String uid;
  final String? displayName;
  final String? photoUrl;
  final String email;
  final int points;

  Map<String, dynamic> toJson() => _$RankingItemToJson(this);

  @override
  List<Object?> get props => [uid, displayName, photoUrl, email, points];
}
