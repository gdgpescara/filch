import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../_shared/widgets/app_card.dart';
import '../../models/archived_quest.dart';
import 'archived_quest_card_row_value.dart';

class ArchivedQuestCard extends StatelessWidget {
  const ArchivedQuestCard(this.archivedQuest, {super.key});

  final ArchivedQuest archivedQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArchivedQuestCardRowValue(
            label: 'quest:',
            value: archivedQuest.quest.id,
          ),
          const SizedBox(height: 10),
          ArchivedQuestCardRowValue(
            label: 'archived on:',
            value: DateFormat('dd MMM • HH:mm').format(archivedQuest.archivedAt),
          ),
          const SizedBox(height: 10),
          ArchivedQuestCardRowValue(
            label: 'points:',
            value: '${archivedQuest.points}',
          ),
        ],
      ),
    );
  }
}
