import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'speaker_link.dart';

part 'speaker.g.dart';

/// Represents a speaker for a session
@JsonSerializable()
class Speaker extends Equatable {
  const Speaker({
    required this.id,
    required this.name,
    this.bio,
    this.tagLine,
    this.profilePicture,
    this.links = const [],
  });

  /// Creates a [Speaker] from a JSON map
  factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);

  /// Converts this [Speaker] to a JSON map
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  /// Unique identifier for the speaker
  final String id;

  /// Full name of the speaker
  final String name;

  /// Biography of the speaker
  final String? bio;

  /// Professional tagline or title of the speaker
  final String? tagLine;

  /// URL to the speaker's profile picture
  final String? profilePicture;

  /// List of social media and web links for the speaker
  final List<SpeakerLink> links;

  /// Creates a copy of this [Speaker] with the given fields replaced
  Speaker copyWith({
    String? id,
    String? name,
    String? bio,
    String? tagLine,
    String? profilePicture,
    List<SpeakerLink>? links,
  }) {
    return Speaker(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      tagLine: tagLine ?? this.tagLine,
      profilePicture: profilePicture ?? this.profilePicture,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [id, name, bio, tagLine, profilePicture, links];
}
