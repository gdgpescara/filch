part of 'sign_in_page.dart';

BlocWidgetListener<SignInState> _signInStateListener(VoidCallback onSignedInNavigateTo) => (context, state) {
  switch (state) {
    case SignInLoading():
      LoaderOverlay.show(context);
      break;
    case SignInSuccess():
      LoaderOverlay.hide(context);
      onSignedInNavigateTo();
      break;
    case SignInFailure(failure: final failure):
      LoaderOverlay.hide(context);
      switch (failure.code) {
        case 'account-exists-with-different-credential':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                failure.message,
                style: context.textTheme.displayMedium?.copyWith(color: context.colorScheme.onError),
              ),
              backgroundColor: context.colorScheme.error,
              duration: const Duration(seconds: 20),
              showCloseIcon: true,
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.auth.errors.sign_in_failed), backgroundColor: context.colorScheme.error),
          );
          break;
      }
      break;
    default:
      break;
  }
};
