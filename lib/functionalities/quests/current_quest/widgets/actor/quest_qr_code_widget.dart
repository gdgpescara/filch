import 'package:flutter/material.dart';

import '../../../../_shared/widgets/app_card.dart';
import '../../../../user/profile/widgets/user_qr_code.dart';

class QuestQrCodeWidget extends StatelessWidget {
  const QuestQrCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: UserQrCode(dimension: 200),
    );
  }
}
