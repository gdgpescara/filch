import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../use_cases/remove_account_use_case.dart';

class RemoveAccountButton extends StatelessWidget {
  const RemoveAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _removeAccount(context),
      child: Text(
        t.profile.remove_account.button,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  void _removeAccount(BuildContext context) {
    showAdaptiveDialog<void>(context: context, builder: (context) => const _RemoveAccountDialog());
  }
}

class _RemoveAccountDialog extends StatefulWidget {
  const _RemoveAccountDialog();

  @override
  State<_RemoveAccountDialog> createState() => _RemoveAccountDialogState();
}

class _RemoveAccountDialogState extends State<_RemoveAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.profile.remove_account.dialog.title),
      content: Text(t.profile.remove_account.dialog.content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.buttons.cancel),
        ),
        TextButton(
          onPressed: () => _removeAccount(context),
          child: Text(t.profile.remove_account.dialog.confirm),
        ),
      ],
    );
  }

  Future<void> _removeAccount(BuildContext context) async {
    // TODOnavigate to login
    // await Navigator.pushNamed(context, SignInPage.routeName);
    await GetIt.I<RemoveAccountUseCase>()().when(
      progress: () => LoaderOverlay.show(context),
      success: (_) => _navigateToSplash(context),
      failure: (e) => _showError(context),
    );
  }

  void _navigateToSplash(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.profile.remove_account.success),
        backgroundColor: Theme.of(context).extension<CustomColors>()?.success,
      ),
    );
    // TODOnavigate to splash
    // Navigator.pushNamedAndRemoveUntil(context, SplashPage.routeName, (route) => false);
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.profile.remove_account.error),
        backgroundColor: Theme.of(context).extension<CustomColors>()?.error,
      ),
    );
  }
}
