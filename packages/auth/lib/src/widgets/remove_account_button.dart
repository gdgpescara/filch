import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../use_cases/remove_account_use_case.dart';

class RemoveAccountButton extends StatelessWidget {
  const RemoveAccountButton({super.key, required this.onNeedLogin, required this.onAccountRemoved});

  final VoidCallback onNeedLogin;
  final VoidCallback onAccountRemoved;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _removeAccount(context),
      child: Text(t.profile.remove_account.button.toUpperCase()),
    );
  }

  void _removeAccount(BuildContext context) {
    showAdaptiveDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.profile.remove_account.dialog.title),
          content: Text(t.profile.remove_account.dialog.content),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(t.common.buttons.cancel)),
            TextButton(
              onPressed: () => _confirmAccountRemoval(context),
              child: Text(t.profile.remove_account.dialog.confirm),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmAccountRemoval(BuildContext context) async {
    await GetIt.I<RemoveAccountUseCase>()().when(
      progress: () => LoaderOverlay.show(context),
      success: (_) => _navigateToSplash(context),
      error: (e) => _onError(context, e),
    );
  }

  void _navigateToSplash(BuildContext context) {
    LoaderOverlay.hide(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          t.profile.remove_account.success,
          style: context.textTheme.bodyMedium?.copyWith(
            color: appColors.success.brightnessColor(context).onColorContainer,
          ),
        ),
        backgroundColor: appColors.success.brightnessColor(context).colorContainer,
      ),
    );
    Navigator.pop(context);
    onAccountRemoved();
  }

  Future<void> _onError(BuildContext context, CustomError failure) async {
    LoaderOverlay.hide(context);
    if (failure.message.contains('firebase_auth/requires-recent-login')) {
      await showAdaptiveDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.profile.remove_account.need_login.dialog.title),
            content: Text(t.profile.remove_account.need_login.dialog.content),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(t.common.buttons.cancel)),
              TextButton(onPressed: onNeedLogin, child: Text(t.common.buttons.ok)),
            ],
          );
        },
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.profile.remove_account.error,
            style: context.textTheme.bodyMedium?.copyWith(
              color: appColors.error.brightnessColor(context).onColorContainer,
            ),
          ),
          backgroundColor: appColors.error.brightnessColor(context).colorContainer,
        ),
      );
      Navigator.pop(context);
    }
  }
}
