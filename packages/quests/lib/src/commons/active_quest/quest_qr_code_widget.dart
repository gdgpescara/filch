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
      style: AppCardStyle.bordered,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.m),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(RadiusSize.m),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: UserQrCode(user: user),
          ),
          const SizedBox(height: Spacing.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner_rounded,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: Spacing.s),
              Expanded(
                child: Text(
                  t.quests.active_quest.qr_code.hint,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
