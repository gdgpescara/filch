import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets.dart';

class NoQuestAssignedWidget extends StatelessWidget {
  const NoQuestAssignedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(Spacing.m),
        children: const [
          AdventureHeroWidget(),
          SizedBox(height: Spacing.m),
          QuestAdventureCardWidget(),
          SizedBox(height: Spacing.l),
          QuestTipsWidget(),
        ],
      ),
    );
  }
}
