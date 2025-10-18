import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets.dart';

class QuestRequestClosedWidget extends StatelessWidget {
  const QuestRequestClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(Spacing.m),
        children: const [
          QuestClosedHeroWidget(),
          SizedBox(height: Spacing.l),
          QuestClosedMessageWidget(),
          SizedBox(height: Spacing.l),
          QuestSuggestionsWidget(),
        ],
      ),
    );
  }
}
