import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'stat_item_widget.dart';

class MotivationalStatsWidget extends StatelessWidget {
  const MotivationalStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const StatItemWidget(
            icon: Icons.emoji_events_rounded,
            title: 'Earn Points',
            subtitle: 'Complete\nquests',
          ),
          Container(
            width: 1,
            height: 40,
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
          const StatItemWidget(
            icon: Icons.trending_up_rounded,
            title: 'Climb Ranks',
            subtitle: 'Beat\nothers',
          ),
          Container(
            width: 1,
            height: 40,
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
          const StatItemWidget(
            icon: Icons.celebration_rounded,
            title: 'Have Fun',
            subtitle: 'Enjoy the\nevent',
          ),
        ],
      ),
    );
  }
}
