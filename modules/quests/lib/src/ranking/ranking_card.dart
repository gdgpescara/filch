import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/ranking_item.dart';

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
    return AppCard(
      style: AppCardStyle.normal,
      padding: const EdgeInsets.all(Spacing.m).copyWith(top: Spacing.s),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: '$position ',
                style: context.getTextTheme(TextThemeType.themeSpecific).displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _textColor(context),
                    ),
                children: [
                  TextSpan(
                    text: item.displayName,
                    style: context.getTextTheme().titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _textColor(context),
                        ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: t.quests.ranking.points.label(n: item.points),
                style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(
                      color: _textColor(context),
                    ),
                children: [
                  TextSpan(
                    text: '${item.points}',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _textColor(context),
                      shadows: isUser ? [Shadow(color: context.theme.colorScheme.primary, blurRadius: 5)] : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _textColor(BuildContext context) {
    if(position == 1) {
      return appColors.appYellow.seed;
    }
    if(isUser) {
      return context.colorScheme.tertiary;
    }
    return context.colorScheme.onSurface;
  }
}
