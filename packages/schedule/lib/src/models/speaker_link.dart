import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speaker_link.g.dart';

/// Represents a social media or web link for a speaker
@JsonSerializable()
class SpeakerLink extends Equatable {
  const SpeakerLink({
    required this.title,
    required this.url,
    required this.linkType,
  });

  /// Creates a [SpeakerLink] from a JSON map
  factory SpeakerLink.fromJson(Map<String, dynamic> json) => _$SpeakerLinkFromJson(json);

  /// Converts this [SpeakerLink] to a JSON map
  Map<String, dynamic> toJson() => _$SpeakerLinkToJson(this);

  /// The title/name of the link (e.g., "Twitter", "LinkedIn")
  final String title;

  /// The URL of the link
  final String url;

  /// The type of link (e.g., "Twitter", "LinkedIn", "Website")
  final String linkType;

  /// Creates a copy of this [SpeakerLink] with the given fields replaced
  SpeakerLink copyWith({
    String? title,
    String? url,
    String? linkType,
  }) {
    return SpeakerLink(
      title: title ?? this.title,
      url: url ?? this.url,
      linkType: linkType ?? this.linkType,
    );
  }

  @override
  List<Object?> get props => [title, url, linkType];
}
