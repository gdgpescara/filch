import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';
import 'quest_sub_types_enum.dart';
import 'quest_types_enum.dart';

part 'quest.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Quest extends Equatable {
  const Quest({
    required this.id,
    this.title,
    required this.description,
    required this.points,
    required this.validityStart,
    required this.validityEnd,
    required this.executionTime,
    required this.type,
    required this.queueTime,
    required this.actor,
    required this.maxQueue,
    required this.groupSize,
    required this.requestAccepted,
    required this.qrCode,
    required this.question,
    required this.answers,
    required this.subType,
    required this.verificationFunction,
  });

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  final String id;
  final Map<String, String>? title;
  final Map<String, String> description;
  final List<int> points;
  @TimestampDateTimeConverter()
  @JsonKey(includeToJson: false)
  final DateTime validityStart;
  @TimestampDateTimeConverter()
  @JsonKey(includeToJson: false)
  final DateTime validityEnd;
  @IntDurationConverter()
  final Duration executionTime;
  final QuestTypeEnum type;

  //region Actor quest section
  @IntDurationConverter()
  final Duration? queueTime;
  final String? actor;
  final int? maxQueue;
  final int? groupSize;
  final bool? requestAccepted;

  //endregion

  //region Quiz quest section
  final String? qrCode;
  final Map<String, String>? question;
  final List<Answer>? answers;

  //endregion

  //region Social quest section
  final QuestSubTypeEnum? subType;
  final String? verificationFunction;

  //endregion

  bool get isMultipleChoice => (answers?.where((answer) => answer.isCorrect).length ?? 0) > 1;

  Map<String, dynamic> toJson() => _$QuestToJson(this);

  @override
  List<Object?> get props => [
    id,
    description,
    points,
    validityStart,
    validityEnd,
    executionTime,
    type,
    queueTime,
    actor,
    maxQueue,
    groupSize,
    requestAccepted,
    qrCode,
    question,
    answers,
    subType,
    verificationFunction,
  ];
}
