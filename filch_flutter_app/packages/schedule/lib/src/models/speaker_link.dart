import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'speaker_link_type.dart';

part 'speaker_link.g.dart';

/// Represents a social media or web link for a speaker
@JsonSerializable(createToJson: false)
class SpeakerLink extends Equatable {
  const SpeakerLink({
    required this.title,
    required this.url,
  });

  /// Creates a [SpeakerLink] from a JSON map
  factory SpeakerLink.fromJson(Map<String, dynamic> json) => _$SpeakerLinkFromJson(json);

  /// The type/title of the link
  @JsonKey(fromJson: SpeakerLinkType.fromJsonSafe)
  final SpeakerLinkType? title;

  /// The URL of the link
  final String url;

  /// Creates a copy of this [SpeakerLink] with the given fields replaced
  SpeakerLink copyWith({
    SpeakerLinkType? title,
    String? url,
  }) {
    return SpeakerLink(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [title, url];
}
