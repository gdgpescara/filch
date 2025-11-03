import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AdventureHeroWidget extends StatelessWidget {
  const AdventureHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.xl),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.secondary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(
        Icons.explore_rounded,
        size: 64,
        color: context.colorScheme.onSecondaryContainer,
      ),
    );
  }
}
