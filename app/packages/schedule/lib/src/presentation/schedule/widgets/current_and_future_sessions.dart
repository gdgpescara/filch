import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import 'session_card/session_card.dart';

class CurrentAndFutureSessions extends StatelessWidget {
  const CurrentAndFutureSessions({
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

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Semantics(
          label: session.isCurrentlyRunning
              ? t.schedule.sessions.semantics.current_talk(title: session.title)
              : t.schedule.sessions.semantics.upcoming_talk(title: session.title),
          child: SessionCard(session, onTap: onSessionTap),
        );
      },
      separatorBuilder: (context, index) => const Gap.vertical(Spacing.m),
      itemCount: sessions.length,
    );
  }
}
