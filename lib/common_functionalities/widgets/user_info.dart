import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import 'app_card.dart';
import 'label_value.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(this.user, {super.key, this.hasNimbusTicket = false});

  final User? user;
  final bool hasNimbusTicket;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user?.displayName != null && user?.displayName != '') ...[
            LabelValue(
              label: t.profile.user_info.name.label,
              value: user?.displayName,
            ),
            const SizedBox(height: 20),
          ],
          LabelValue(
            label: t.profile.user_info.email.label,
            value: user?.email,
          ),
          if (hasNimbusTicket) ...[
            const SizedBox(height: 20),
            LabelValue(
              label: t.profile.user_info.nimbus_ticket.label,
              value: t.profile.user_info.nimbus_ticket.message,
            ),
          ],
        ],
      ),
    );
  }
}
