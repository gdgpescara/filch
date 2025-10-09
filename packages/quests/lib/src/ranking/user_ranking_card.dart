import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/ranking_item.dart';
import 'card/ranking_card.dart';

class UserRankingCard extends StatelessWidget {
  const UserRankingCard({
    super.key,
    required this.item,
    required this.position,
  });

  final RankingItem item;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.m,
            vertical: Spacing.s,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.tertiary.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(RadiusSize.s),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: context.colorScheme.onTertiaryContainer,
              ),
              const SizedBox(width: Spacing.xs),
              Text(
                t.quests.ranking.your_position,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s),
        RankingCard(
          item: item,
          position: position,
          isUser: true,
        ),
      ],
    );
  }
}
