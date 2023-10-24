import 'package:flutter/material.dart';

import '../../models/archived_quest.dart';
import 'archived_quest_card.dart';

class ArchivedQuestsList extends StatelessWidget {
  const ArchivedQuestsList(this.archivedQuests, {super.key});

  final List<ArchivedQuest> archivedQuests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: archivedQuests.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) => ArchivedQuestCard(archivedQuests[index]),
    );
  }
}
