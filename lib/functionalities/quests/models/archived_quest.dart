import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../_shared/json_converters/timestamp_date_time_converter.dart';
import 'quest.dart';

part 'archived_quest.g.dart';

@JsonSerializable(explicitToJson: true)
class ArchivedQuest extends Equatable {
  const ArchivedQuest({
    required this.quest,
    required this.points,
    required this.uid,
    required this.archivedAt,
  });

  factory ArchivedQuest.fromJson(Map<String, dynamic> json) => _$ArchivedQuestFromJson(json);

  final Quest quest;
  final int points;
  final String uid;
  @TimestampDateTimeConverter()
  final DateTime archivedAt;

  Map<String, dynamic> toJson() => _$ArchivedQuestToJson(this);

  @override
  List<Object?> get props => [
        quest,
        points,
        uid,
        archivedAt,
      ];
}
