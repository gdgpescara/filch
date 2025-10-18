import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestTipsWidget extends StatelessWidget {
  const QuestTipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates_rounded,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: Spacing.s),
              Expanded(
                child: Text(
                  t.quests.active_quest.quest_tips_title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          ..._buildQuestTips(context),
        ],
      ),
    );
  }

  List<Widget> _buildQuestTips(BuildContext context) {
    final tips = [
      (Icons.phone_android_rounded, t.quests.active_quest.tip_phone_charged),
      (Icons.groups_rounded, t.quests.active_quest.tip_interact_participants),
      (Icons.location_on_rounded, t.quests.active_quest.tip_explore_areas),
    ];

    return tips
        .map(
          (tip) => Padding(
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
                    tip.$1,
                    size: 16,
                    color: context.colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: Text(
                    tip.$2,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
