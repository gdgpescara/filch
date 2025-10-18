import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

class UserPointsItemCard extends StatelessWidget {
  const UserPointsItemCard(this.point, {super.key});

  final Points point;

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(point.type, context);
    return AppCard(
      style: AppCardStyle.caption,
      borderColor: typeColor.color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Spacing.s),
                decoration: BoxDecoration(
                  color: typeColor.colorContainer,
                  borderRadius: BorderRadius.circular(RadiusSize.s),
                ),
                child: Icon(_getTypeIcon(point.type), color: typeColor.color, size: 20),
              ),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.user.my_points_details.points_item_card.type.value[point.type.name] ?? 'Unknown',
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      GetIt.I<DateFormat>(instanceName: 'full').format(point.assignedAt),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                decoration: BoxDecoration(
                  color: typeColor.color,
                  borderRadius: BorderRadius.circular(RadiusSize.m),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      color: typeColor.onColor,
                      size: 16,
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '+${point.points}',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: typeColor.onColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(PointsTypeEnum type) {
    switch (type) {
      case PointsTypeEnum.quest:
        return Icons.quiz_rounded;
      case PointsTypeEnum.staff:
        return Icons.work_rounded;
    }
  }

  ColorFamily _getTypeColor(PointsTypeEnum type, BuildContext context) {
    switch (type) {
      case PointsTypeEnum.quest:
        return appColors.googleBlue.brightnessColor(context);
      case PointsTypeEnum.staff:
        return appColors.googleGreen.brightnessColor(context);
    }
  }
}
