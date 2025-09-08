import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/models.dart';

class SessionSpeakers extends StatelessWidget {
  const SessionSpeakers({
    super.key,
    required this.speakers,
    this.sectionTitleStyle,
    this.speakerNameStyle,
    this.speakerAvatarRadius = 20,
    this.showAllInfo = false,
  });

  final List<Speaker> speakers;
  final double speakerAvatarRadius;
  final TextStyle? sectionTitleStyle;
  final TextStyle? speakerNameStyle;
  final bool showAllInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.schedule.sessions.session_speakers.label(count: speakers.length),
          style: sectionTitleStyle ?? context.getTextTheme(TextThemeType.monospace).bodyMedium,
        ),
        const SizedBox(height: Spacing.s),
        ...speakers.map((speaker) => _buildSpeakerRow(context, speaker)),
      ],
    );
  }

  Widget _buildSpeakerRow(BuildContext context, Speaker speaker) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: speakerAvatarRadius,
            backgroundImage: speaker.profilePicture?.isNotEmpty ?? false ? NetworkImage(speaker.profilePicture!) : null,
            child: speaker.profilePicture?.isEmpty ?? false ? Text(speaker.name[0]) : null,
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.name,
                  style: speakerNameStyle ?? context.textTheme.bodyMedium,
                ),
                if (speaker.tagLine != null && speaker.tagLine!.isNotEmpty) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    speaker.tagLine!,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                if (showAllInfo && speaker.bio != null && speaker.bio!.isNotEmpty) ...[
                  const SizedBox(height: Spacing.m),
                  Text(
                    speaker.bio!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                if (showAllInfo && speaker.links.isNotEmpty) ...[
                  Wrap(
                    spacing: Spacing.m,
                    runSpacing: Spacing.s,
                    children: speaker.links
                        .where((link) => link.title != null)
                        .map(
                          (link) => IconButton(
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(link.url))) {
                                unawaited(launchUrl(Uri.parse(link.url), mode: LaunchMode.externalApplication));
                              }
                            },
                            icon: Icon(
                              link.title!.icon,
                              size: kMinInteractiveDimension * 0.5,
                              color: context.colorScheme.primary,
                              semanticLabel: link.title!.displayName,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
