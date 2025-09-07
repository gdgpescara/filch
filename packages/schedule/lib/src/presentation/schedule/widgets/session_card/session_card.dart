import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';
import 'session_info.dart';
import 'session_speakers.dart';
import 'session_time.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return AppCard(
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

          if (session.description.isNotEmpty) ...[
            const SizedBox(height: Spacing.s),
            Text(
              session.description,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: Spacing.s),
          SessionInfo(session: session),

          if (session.speakers.isNotEmpty) ...[
            const SizedBox(height: Spacing.s),
            SessionSpeakers(speakers: session.speakers),
          ],
        ],
      ),
    );
  }
}
