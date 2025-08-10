import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

/// Represents the language of a session
@JsonSerializable()
class Language extends Equatable {
  const Language({
    required this.id,
    required this.name,
  });

  /// Creates a [Language] from a JSON map
  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  /// Converts this [Language] to a JSON map
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  /// Unique identifier for the language
  final int id;

  /// Name of the language (e.g., "English", "Italian", "Spanish")
  final String name;

  /// Creates a copy of this [Language] with the given fields replaced
  Language copyWith({
    int? id,
    String? name,
  }) {
    return Language(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
