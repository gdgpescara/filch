import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/src/actor/user_qr_code.dart';
import 'package:ui/ui.dart';

class QuestQrCodeWidget extends StatelessWidget {
  const QuestQrCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserQrCode(),
          const SizedBox(height: 10),
          Text(t.quests.active_quest.actors.hint),
        ],
      ),
    );
  }
}
