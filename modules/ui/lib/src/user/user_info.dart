import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import '../../ui.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(this.user, {super.key, this.extra});

  final User? user;
  final Widget? extra;

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
          extra ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
