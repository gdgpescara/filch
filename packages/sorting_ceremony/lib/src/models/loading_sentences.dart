import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loading_sentences.g.dart';

@JsonSerializable(createToJson: false)
class LoadingSentences extends Equatable {
  const LoadingSentences({required this.sentences});

  factory LoadingSentences.fromJson(Map<String, dynamic> json) => _$LoadingSentencesFromJson(json);

  final List<Map<String, String>> sentences;

  @override
  List<Object?> get props => [sentences];
}
