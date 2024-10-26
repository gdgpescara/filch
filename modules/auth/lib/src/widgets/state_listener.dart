part of 'sign_in_page.dart';

BlocWidgetListener<SignInState> _signInStateListener(VoidCallback onSignedInNavigateTo) => (context, state) {
      switch (state) {
        case SignInSuccess():
          onSignedInNavigateTo();
          break;
        case SignInFailure(failure: final failure):
          switch (failure.code) {
            case 'account-exists-with-different-credential':
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    failure.message,
                    style: context
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: context.colorScheme.onError),
                  ),
                  backgroundColor: context.colorScheme.error,
                  duration: const Duration(seconds: 20),
                  showCloseIcon: true,
                ),
              );
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${failure.code}: ${failure.message}'),
                  backgroundColor: context.colorScheme.error,
                ),
              );
              break;
          }
          break;
        default:
          break;
      }
    };
