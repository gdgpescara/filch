import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../../widgets/session_speakers.dart';
import '../../widgets/session_tags.dart';
import 'session_detail_info.dart';

class SessionDetailContent extends StatelessWidget {
  const SessionDetailContent({
    super.key,
    required this.session,
    required this.delay,
  });

  final Session session;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.l),
      children: [
        Text(
          session.title,
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Spacing.l),
        SessionDetailInfo(session: session, delay: delay),
        if (session.description?.isNotEmpty ?? false) ...[
          const Gap.vertical(Spacing.l),
          Text(
            'Descrizione',
            style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap.vertical(Spacing.m),
          Text(
            session.description!,
            style: context.textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: Spacing.xl),
        SessionTags(session: session),
        if (session.speakers.isNotEmpty) ...[
          const Gap.vertical(Spacing.xl),
          SessionSpeakers(
            speakers: session.speakers,
            sectionTitleStyle: context
                .getTextTheme(TextThemeType.monospace)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            speakerNameStyle: context.textTheme.bodyLarge,
            speakerAvatarRadius: 26,
            showAllInfo: true,
          ),
        ],
      ],
    );
  }
}
