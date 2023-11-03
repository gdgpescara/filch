import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class QuestRequestClosedWidget extends StatelessWidget {
  const QuestRequestClosedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(t.active_quest.request_closed),
    );
  }
}
