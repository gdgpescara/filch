import 'package:flutter/material.dart';

import '../../../common_functionalities/widgets/app_card.dart';
import '../../../i18n/strings.g.dart';
import '../../profile/widgets/user_qr_code.dart';

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
          Text(t.active_quest.actors.hint),
        ],
      ),
    );
  }
}
