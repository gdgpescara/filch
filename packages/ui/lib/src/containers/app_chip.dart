import 'package:flutter/material.dart';

import '../../ui.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    this.icon,
    required this.text,
    required this.color,
  });

  final IconData? icon;
  final String text;
  final CustomColor color;

  @override
  Widget build(BuildContext context) {
    final colorFamily = color.brightnessColor(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.s,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorFamily.colorContainer.withValues(alpha: 0.2),
        border: Border.all(color: colorFamily.colorContainer),
        borderRadius: BorderRadius.circular(RadiusSize.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12), const SizedBox(width: Spacing.s)],
          Text(
            text,
            style: context.getTextTheme(TextThemeType.monospace).bodySmall,
          ),
        ],
      ),
    );
  }
}
