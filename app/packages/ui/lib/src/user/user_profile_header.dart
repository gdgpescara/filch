import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i18n/i18n.dart';

import '../../ui.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
    required this.user,
    this.team,
    this.staffUser = false,
    this.sponsorUser = false,
  });

  final firebase_auth.User? user;
  final Team? team;
  final bool staffUser;
  final bool sponsorUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCard(
          style: AppCardStyle.bordered,
          child: Column(
            children: [
              UserPicture(
                imageUrl: user?.photoURL,
                teamImageUrl: team?.imageUrl,
              ),
              UserInfo(user, teamName: team?.name),
            ],
          ),
        ),
        Positioned(
          top: Spacing.s,
          right: Spacing.s,
          child: IconButton(
            onPressed: () => _showQrCodeDialog(context),
            tooltip: t.user.profile.qr_code.show,
            padding: const EdgeInsets.all(Spacing.s),
            icon: const Icon(FontAwesomeIcons.qrcode),
          ),
        ),
        Positioned(
          top: Spacing.m,
          left: Spacing.m,
          child: AppChip(
            customColor: staffUser
                ? appColors.googleYellow
                : sponsorUser
                ? appColors.googleBlue
                : appColors.googleGreen,
            text: staffUser
                ? t.user.profile.user_info.roles.staff
                : sponsorUser
                ? t.user.profile.user_info.roles.sponsor
                : t.user.profile.user_info.roles.attendee,
          ),
        ),
      ],
    );
  }

  void _showQrCodeDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: context.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserQrCode(user: user, dimension: 250),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.user.profile.qr_code.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
