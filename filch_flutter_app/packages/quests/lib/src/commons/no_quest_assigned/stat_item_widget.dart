import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StatItemWidget extends StatelessWidget {
  const StatItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: context.colorScheme.secondary,
            size: 24,
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
