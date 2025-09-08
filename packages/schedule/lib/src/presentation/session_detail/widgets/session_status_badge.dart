import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';

class SessionStatusBadge extends StatelessWidget {
  const SessionStatusBadge({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    final String statusText;
    final Color statusColor;
    final IconData statusIcon;

    if (session.isCurrentlyRunning) {
      statusText = 'In corso';
      statusColor = context.colorScheme.primary;
      statusIcon = Icons.play_circle_filled;
    } else if (session.hasEnded) {
      statusText = 'Terminata';
      statusColor = context.colorScheme.secondary;
      statusIcon = Icons.check_circle;
    } else {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.m,
        vertical: Spacing.s,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(RadiusSize.m),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 20,
          ),
          const SizedBox(width: Spacing.s),
          Text(
            statusText,
            style: context.textTheme.titleSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
