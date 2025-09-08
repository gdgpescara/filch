import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

/// Enum representing the different types of speaker links
@JsonEnum()
enum SpeakerLinkType {
  @JsonValue('LinkedIn')
  linkedIn('LinkedIn', FontAwesomeIcons.linkedin),

  @JsonValue('Instagram')
  instagram('Instagram', FontAwesomeIcons.instagram),

  @JsonValue('X (Twitter)')
  xTwitter('X (Twitter)', FontAwesomeIcons.xTwitter),

  @JsonValue('Blog')
  blog('Blog', FontAwesomeIcons.blog),

  @JsonValue('Company Website')
  companyWebsite('Company Website', FontAwesomeIcons.building);

  const SpeakerLinkType(this.displayName, this.icon);

  /// The display name for the link type
  final String displayName;

  /// The Font Awesome icon for the link type
  final IconData icon;

  /// Custom fromJson method that handles unknown values safely
  static SpeakerLinkType? fromJsonSafe(String? json) {
    if (json == null) return null;

    try {
      // Cerca il valore nell'enum usando i JsonValue
      for (final value in SpeakerLinkType.values) {
        if (value.displayName == json) {
          return value;
        }
      }
      // Se non trova nulla, ritorna null
      return null;
    } catch (e) {
      return null;
    }
  }
}
