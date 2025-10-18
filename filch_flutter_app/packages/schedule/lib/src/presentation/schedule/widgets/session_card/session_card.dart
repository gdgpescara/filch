import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';
import '../../../widgets/session_speakers.dart';
import '../../../widgets/session_tags.dart';
import 'session_time.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(this.session, {super.key, required this.onTap});

  final Session session;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => !session.isServiceSession ? onTap(session.id) : null,
      child: AppCard(
        style: AppCardStyle.bordered,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionTime(session: session),

            const SizedBox(height: Spacing.m),
            Text(
              session.title,
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: Spacing.m),
            SessionTags(session: session),

            if (session.speakers.isNotEmpty) ...[
              const SizedBox(height: Spacing.m),
              SessionSpeakers(speakers: session.speakers),
            ],
          ],
        ),
      ),
    );
  }
}
