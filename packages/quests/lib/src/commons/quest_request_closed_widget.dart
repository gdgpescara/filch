import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class QuestRequestClosedWidget extends StatelessWidget {
  const QuestRequestClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(t.quests.active_quest.request_closed));
  }
}
