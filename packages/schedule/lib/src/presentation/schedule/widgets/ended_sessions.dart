import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import 'session_card/session_card.dart';

class EndedSessions extends StatelessWidget {
  const EndedSessions({
    required this.sessions,
    required this.onSessionTap,
    super.key,
  });

  final List<Session> sessions;
  final ValueChanged<String> onSessionTap;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: t.schedule.sessions.semantics.ended_section_label(count: sessions.length),
      hint: t.schedule.sessions.semantics.ended_section_hint,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        childrenPadding: const EdgeInsets.symmetric(horizontal: Spacing.s),
        backgroundColor: context.colorScheme.secondaryContainer,
        collapsedBackgroundColor: context.colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSize.m),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusSize.m),
        ),
        title: Text(
          t.schedule.sessions.ended_sessions_count(count: sessions.length),
          style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          t.schedule.sessions.ended_sessions_subtitle,
          style: context.textTheme.bodySmall,
        ),
        children: sessions
            .map(
              (session) => _EndedSessionCard(
                session: session,
                isLast: session == sessions.last,
                onSessionTap: onSessionTap,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _EndedSessionCard extends StatelessWidget {
  const _EndedSessionCard({
    required this.session,
    required this.isLast,
    required this.onSessionTap,
  });

  final Session session;
  final ValueChanged<String> onSessionTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? Spacing.s : Spacing.m),
        child: SessionCard(session, onTap: onSessionTap),
      ),
    );
  }
}
