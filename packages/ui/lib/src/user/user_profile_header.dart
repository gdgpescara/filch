import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key, required this.user});

  final firebase_auth.User? user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppCard(
          style: AppCardStyle.bordered,
          child: Column(
            children: [
              UserPicture(imageUrl: user?.photoURL),
              UserInfo(user),
            ],
          ),
        ),
        Positioned(
          top: Spacing.s,
          right: Spacing.s,
          child: IconButton(
            onPressed: () => _showQrCodeDialog(context),
            tooltip: 'Show QR Code',
            padding: const EdgeInsets.all(Spacing.s),
            icon: const Icon(FontAwesomeIcons.qrcode),
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
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
