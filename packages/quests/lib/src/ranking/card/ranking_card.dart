import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../models/ranking_item.dart';
import '../ranking_utils.dart';
import 'points_badge.dart';
import 'position_badge.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
    required this.item,
    required this.position,
    required this.isUser,
  });

  final RankingItem item;
  final int position;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(RadiusSize.m),
      child: Container(
        padding: const EdgeInsets.all(Spacing.m),
        decoration: BoxDecoration(
          gradient: RankingUtils.getGradient(context, position),
          borderRadius: BorderRadius.circular(RadiusSize.m),
          border: isUser
              ? Border.all(color: RankingUtils.getPositionColor(context, position), width: 2)
              : null,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            PositionBadge(position: position),
            const SizedBox(width: Spacing.m),
            Expanded(
              child: Text(
                item.displayName ?? item.email,
                style: context.getTextTheme().titleLarge?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: Spacing.m),
            PointsBadge(points: item.points, position: position),
          ],
        ),
      ),
    );
  }
}
