import 'package:flutter/material.dart';

import '../../ui.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    this.icon,
    this.padding,
    this.borderRadius,
    this.text,
    this.child,
    this.customColor,
    this.color,
  }) : assert(!(text != null && child != null), 'Only one of text or child can be provided'),
       assert(!(customColor != null && color != null), 'Only one of customColor or color can be provided');

  final IconData? icon;
  final EdgeInsets? padding;
  final double? borderRadius;
  final String? text;
  final Widget? child;
  final CustomColor? customColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final actualColor = (customColor?.brightnessColor(context).colorContainer ?? color)!;
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: Spacing.s,
            vertical: Spacing.xs,
          ),
      decoration: BoxDecoration(
        color: actualColor.withValues(alpha: 0.2),
        border: Border.all(color: actualColor),
        borderRadius: BorderRadius.circular(borderRadius ?? RadiusSize.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12), const SizedBox(width: Spacing.s)],
          if (text != null)
            Text(
              text!,
              style: context.getTextTheme(TextThemeType.monospace).bodySmall,
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
