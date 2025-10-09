import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i18n/i18n.dart';
import '../../ui.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(this.user, {super.key, this.extra});

  final User? user;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (user?.displayName != null && (user?.displayName?.isNotEmpty ?? false)) ...[
          _buildInfoRow(
            context,
            icon: FontAwesomeIcons.user,
            label: t.profile.user_info.name.label,
            value: user!.displayName!,
          ),
          const SizedBox(height: Spacing.m),
        ],
        _buildInfoRow(
          context,
          icon: FontAwesomeIcons.envelope,
          label: t.profile.user_info.email.label,
          value: user?.email ?? 'N/A',
        ),
        if (extra != null) ...[
          const SizedBox(height: Spacing.m),
          extra!,
        ],
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(RadiusSize.s),
          ),
          child: Icon(
            icon,
            size: 20,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: Spacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.textTheme.bodySmall),
              const SizedBox(height: Spacing.xs),
              Text(
                value,
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
