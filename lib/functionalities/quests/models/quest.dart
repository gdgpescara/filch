import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../_shared/json_converters/int_duration_converter.dart';
import '../../_shared/json_converters/timestamp_date_time_converter.dart';
import 'answer.dart';
import 'quest__sub_types_enum.dart';
import 'quest_types_enum.dart';

part 'quest.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Quest extends Equatable {
  const Quest({
    required this.id,
    required this.description,
    required this.malus,
    required this.points,
    required this.validityStart,
    required this.validityEnd,
    required this.executionTime,
    required this.isOneTime,
    required this.type,
    required this.queueTime,
    required this.actorUid,
    required this.maxQueue,
    required this.requestAccepted,
    required this.qrCode,
    required this.question,
    required this.answers,
    required this.subType,
    required this.verificationFunction,
  });

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  final String id;
  final String description;
  final int malus;
  final int points;
  @TimestampDateTimeConverter()
  @JsonKey(includeToJson: false)
  final DateTime validityStart;
  @TimestampDateTimeConverter()
  @JsonKey(includeToJson: false)
  final DateTime validityEnd;
  @IntDurationConverter()
  final Duration executionTime;
  final bool isOneTime;
  final QuestTypeEnum type;

  //region Actor quest section
  @IntDurationConverter()
  final Duration? queueTime;
  final String? actorUid;
  final int? maxQueue;
  final bool? requestAccepted;

  //endregion

  //region Quiz quest section
  final String? qrCode;
  final String? question;
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
        malus,
        points,
        validityStart,
        validityEnd,
        executionTime,
        isOneTime,
        type,
        queueTime,
        actorUid,
        maxQueue,
        requestAccepted,
        qrCode,
        question,
        answers,
        subType,
        verificationFunction,
      ];
}
