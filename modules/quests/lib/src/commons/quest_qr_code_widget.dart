import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestQrCodeWidget extends StatelessWidget {
  const QuestQrCodeWidget({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserQrCode(user: user),
          const SizedBox(height: 10),
          Text(t.quests.active_quest.qr_code.hint),
        ],
      ),
    );
  }
}
