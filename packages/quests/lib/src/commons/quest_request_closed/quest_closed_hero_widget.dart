import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class QuestClosedHeroWidget extends StatelessWidget {
  const QuestClosedHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
