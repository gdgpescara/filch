import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Utility functions for ranking components
class RankingUtils {
  /// Get the color for a position badge
  static Color getPositionColor(BuildContext context, int position) {
    if (position == 1) return appColors.gold.brightnessColor(context).color;
    if (position == 2) return appColors.silver.brightnessColor(context).color;
    if (position == 3) return appColors.bronze.brightnessColor(context).color;
    return context.colorScheme.secondary;
  }

  /// Get the text color for ranking items
  static Color getTextColor(BuildContext context, int position) {
    if (position == 1) return appColors.gold.brightnessColor(context).onColor;
    if (position == 2) return appColors.silver.brightnessColor(context).onColor;
    if (position == 3) return appColors.bronze.brightnessColor(context).onColor;
    return context.colorScheme.onSecondary;
  }

  /// Get gradient for ranking cards
  static Gradient? getGradient(BuildContext context, int position) {
    final color = getPositionColor(context, position);
    return LinearGradient(
      colors: [
        color.withValues(alpha: 0.1),
        color.withValues(alpha: 0.05),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
