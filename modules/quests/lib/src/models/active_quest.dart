import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'quest.dart';

part 'active_quest.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ActiveQuest extends Equatable {
  const ActiveQuest({required this.quest, this.prompt, required this.activatedAt});

  factory ActiveQuest.fromJson(Map<String, dynamic> json) => _$ActiveQuestFromJson(json);

  final Quest quest;
  final Map<String, String>? prompt;
  @TimestampDateTimeConverter()
  final DateTime activatedAt;

  Duration get remainingTime {
    final difference = DateTime.now().difference(activatedAt);
    return quest.executionTime - difference;
  }

  Map<String, dynamic> toJson() => _$ActiveQuestToJson(this);

  @override
  List<Object?> get props => [quest, prompt, activatedAt];
}
