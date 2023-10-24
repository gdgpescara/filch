import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../_shared/json_converters/timestamp_date_time_converter.dart';
import 'quest.dart';

part 'active_quest.g.dart';
@JsonSerializable(explicitToJson: true)
class ActiveQuest extends Equatable {
  const ActiveQuest({
    required this.quest,
    required this.activatedAt,
  });

  factory ActiveQuest.fromJson(Map<String, dynamic> json) => _$ActiveQuestFromJson(json);
  final Quest quest;
  @TimestampDateTimeConverter()
  final DateTime activatedAt;

  Duration get remainingTime {
    final difference = DateTime.now().difference(activatedAt);
    return quest.executionTime - difference;
  }
  Map<String, dynamic> toJson() => _$ActiveQuestToJson(this);

  @override
  List<Object?> get props => [
        quest,
        activatedAt,
      ];
}
