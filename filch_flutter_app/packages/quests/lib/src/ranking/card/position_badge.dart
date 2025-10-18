import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

import '../ranking_utils.dart';

class PositionBadge extends StatelessWidget {
  const PositionBadge({
    super.key,
    required this.position,
  });

  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: RankingUtils.getPositionColor(context, position),
        boxShadow: [
          BoxShadow(
            color: RankingUtils.getPositionColor(context, position).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: _buildPositionWidget(context),
      ),
    );
  }

  Widget _buildPositionWidget(BuildContext context) {
    if (position <= 1) {
      final icon = switch (position) {
        1 => FontAwesomeIcons.trophy,
        _ => FontAwesomeIcons.star,
      };

      return FaIcon(icon, color: RankingUtils.getTextColor(context, position), size: 24);
    }

    // Show position number for others
    return Text(
      '$position',
      style: context
          .getTextTheme(TextThemeType.monospace)
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: RankingUtils.getTextColor(context, position)),
    );
  }
}
