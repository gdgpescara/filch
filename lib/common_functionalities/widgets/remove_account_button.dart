import 'package:flutter/material.dart';

import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../../theme/app_theme.dart';
import '../error_handling/future_extension.dart';
import '../sign_in/sign_in_page.dart';
import '../splash/splash_page.dart';
import '../user/use_cases/remove_account_use_case.dart';
import 'loader_overlay.dart';

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
          child: Text(t.commons.buttons.cancel),
        ),
        TextButton(
          onPressed: () => _removeAccount(context),
          child: Text(t.profile.remove_account.dialog.confirm),
        ),
      ],
    );
  }

  Future<void> _removeAccount(BuildContext context) async {
    await Navigator.pushNamed(context, SignInPage.routeName);
    await injector<RemoveAccountUseCase>()().actions(
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
    Navigator.pushNamedAndRemoveUntil(context, SplashPage.routeName, (route) => false);
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
