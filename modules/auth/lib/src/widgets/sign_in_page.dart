import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/ui.dart';

import '../state/sign_in_cubit.dart';
import 'providers_sign_in.dart';
import 'sign_in_switcher_button.dart';
import 'staff_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.signButtonBuilder});

  final Widget Function(Widget signInButtons) signButtonBuilder;

  @override
  Widget build(BuildContext context) {
    return RemoveFocusContainer(
      child: PopScope(
        canPop: false,
        child: BlocProvider<SignInCubit>(
          create: (context) => GetIt.I(),
          child: BlocListener<SignInCubit, SignInState>(
            listenWhen: (previous, current) => current is SignInActionsState,
            listener: (context, state) {
              switch (state) {
                case SignInSuccess():
                  Navigator.pop(context);
                  break;
                case SignInFailure(failure: final failure):
                  switch (failure.code) {
                    case 'account-exists-with-different-credential':
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            failure.message,
                            style: Theme.of(context)
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
            },
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: signButtonBuilder(
                BlocBuilder<SignInCubit, SignInState>(
                  buildWhen: (previous, current) => current is! SignInActionsState,
                  builder: (context, state) {
                    Widget child() {
                      return switch (state) {
                        SignInWithUserPassword() => const StaffSignIn(),
                        SignInWithProviders() => const ProvidersSignIn(),
                        _ => const SizedBox(),
                      };
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: child(),
                    );
                  },
                ),
              ),
              bottomNavigationBar: const SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SignInSwitcherButton(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
