import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'widgets.dart';

class QuestAdventureCardWidget extends StatelessWidget {
  const QuestAdventureCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.normal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.quests.active_quest.ready_for_adventure,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSecondaryContainer,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.m),
          Text(
            t.quests.active_quest.no_quest_assigned,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.l),
          const MotivationalStatsWidget(),
          const SizedBox(height: Spacing.l),
          const QuestSearchButtonWidget(),
        ],
      ),
    );
  }
}
