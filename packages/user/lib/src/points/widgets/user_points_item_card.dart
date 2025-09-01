import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import 'user_points_value.dart';

class UserPointsItemCard extends StatelessWidget {
  const UserPointsItemCard(this.point, {super.key});

  final Points point;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.normal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: UserPointsValue(
                  label: t.user.my_points_details.points_item_card.type.label,
                  value: t.user.my_points_details.points_item_card.type.value[point.type.name] ?? ' - ',
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: UserPointsValue(
                  label: t.user.my_points_details.points_item_card.points.label(n: point.points),
                  value: '${point.points}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          UserPointsValue(
            label: t.user.my_points_details.points_item_card.assigned_at.label,
            value: GetIt.I<DateFormat>(instanceName: 'full').format(point.assignedAt),
          ),
        ],
      ),
    );
  }
}
