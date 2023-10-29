import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../quests/models/quest.dart';
import '../../user/models/firestore_user.dart';
import '../json_converters/timestamp_date_time_converter.dart';

part 'points.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ArchivedQuest extends Equatable {
  const ArchivedQuest({
    required this.quest,
    required this.points,
    required this.assignedBy,
    required this.assignedAt,
  });

  factory ArchivedQuest.fromJson(Map<String, dynamic> json) => _$ArchivedQuestFromJson(json);

  final Quest? quest;
  final int points;
  @JsonKey(toJson: userToJson)
  final FirestoreUser? assignedBy;
  @TimestampDateTimeConverter()
  final DateTime assignedAt;

  Map<String, dynamic> toJson() => _$ArchivedQuestToJson(this);

  @override
  List<Object?> get props => [
        quest,
        points,
        assignedBy,
        assignedAt,
      ];
}

Map<String, dynamic>? userToJson(FirestoreUser? user) => user != null ? {...user.toJson(), 'uid': user.uid} : null;
