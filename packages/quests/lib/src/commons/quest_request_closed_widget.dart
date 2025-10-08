import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestRequestClosedWidget extends StatelessWidget {
  const QuestRequestClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(Spacing.l),
              decoration: BoxDecoration(
                color: appColors.warning.brightnessColor(context).colorContainer,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: appColors.warning.brightnessColor(context).color.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.schedule_rounded,
                size: 48,
                color: appColors.warning.brightnessColor(context).onColorContainer,
              ),
            ),
            const SizedBox(height: Spacing.l),
            AppCard(
              style: AppCardStyle.normal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.quests.active_quest.request_closed_title,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appColors.warning.brightnessColor(context).onColorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.m),
                  Text(
                    t.quests.active_quest.request_closed,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.l),
            AppCard(
              style: AppCardStyle.caption,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: context.colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: Spacing.s),
                      Expanded(
                        child: Text(
                          t.quests.active_quest.suggestions_title,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.m),
                  ..._buildSuggestionsList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSuggestionsList(BuildContext context) {
    final suggestions = [
      (Icons.people_outline_rounded, t.quests.active_quest.suggestion_explore),
      (Icons.schedule_rounded, t.quests.active_quest.suggestion_schedule),
      (Icons.leaderboard_rounded, t.quests.active_quest.suggestion_ranking),
    ];

    return suggestions
        .map(
          (suggestion) => Padding(
            padding: const EdgeInsets.only(bottom: Spacing.s),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(RadiusSize.s),
                  ),
                  child: Icon(
                    suggestion.$1,
                    size: 16,
                    color: context.colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: Text(suggestion.$2, style: context.textTheme.bodySmall),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
