import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestClosedMessageWidget extends StatelessWidget {
  const QuestClosedMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
    );
  }
}
