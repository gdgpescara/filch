import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../../../common_functionalities/models/points.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import 'user_points_value.dart';

class UserPointsItemCard extends StatelessWidget {
  const UserPointsItemCard(this.point, {super.key});

  final Points point;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: UserPointsValue(
                  label: t.my_points_details.points_item_card.type.label,
                  value: t.my_points_details.points_item_card.type.value[point.type.name] ?? ' - ',
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: UserPointsValue(
                  label: t.my_points_details.points_item_card.points.label(n: point.points),
                  value: '${point.points}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          UserPointsValue(
            label: t.my_points_details.points_item_card.assigned_at.label,
            value: injector<DateFormat>(instanceName: 'full').format(point.assignedAt),
          ),
        ],
      ),
    );
  }
}
