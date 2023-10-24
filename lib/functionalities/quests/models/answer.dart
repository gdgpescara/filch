import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable(explicitToJson: true)
class Answer extends Equatable {
  const Answer({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  final int id;

  final String text;
  final bool isCorrect;

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  List<Object?> get props => [id, text, isCorrect];
}
