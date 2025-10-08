import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../ranking_utils.dart';

class PointsBadge extends StatelessWidget {
  const PointsBadge({
    super.key,
    required this.points,
    required this.position,
  });

  final int points;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      decoration: BoxDecoration(
        color: RankingUtils.getPositionColor(context, position).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(RadiusSize.m),
        border: Border.all(color: RankingUtils.getPositionColor(context, position).withValues(alpha: 0.5)),
      ),
      child: Text(
        '$points',
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: RankingUtils.getPositionColor(context, position),
        ),
      ),
    );
  }
}
