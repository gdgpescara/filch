import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';
import 'session_info.dart';
import 'session_speakers.dart';
import 'session_time.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(this.sessionI, {super.key});

  final Session sessionI;

  @override
  Widget build(BuildContext context) {
    final session = sessionI.copyWith(
      startsAt: DateTime.now().add(const Duration(minutes: 20)),
      endsAt: DateTime.now().add(const Duration(minutes: 50)),
    );
    return AppCard(
      style: AppCardStyle.bordered,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SessionTime(
            startsAt: session.startsAt,
            endsAt: session.endsAt,
          ),

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
