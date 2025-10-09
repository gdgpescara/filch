import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/sign_in_cubit.dart';
import 'providers_sign_in.dart';

part 'state_listener.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.onSignedInNavigateTo});

  final VoidCallback onSignedInNavigateTo;

  @override
  Widget build(BuildContext context) {
    return RemoveFocusContainer(
      child: PopScope(
        canPop: false,
        child: BlocProvider<SignInCubit>(
          create: (context) => GetIt.I(),
          child: BlocListener<SignInCubit, SignInState>(
            listenWhen: (previous, current) => current is SignInActionsState,
            listener: _signInStateListener(onSignedInNavigateTo),
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Background(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.xl),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: const Logo(),
                        ),
                      ),
                      const SizedBox(height: Spacing.xl),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${t.auth.welcome.title}\n',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            TextSpan(
                              text: t.auth.welcome.subtitle,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.xxl),
                      Flexible(
                        child: BlocBuilder<SignInCubit, SignInState>(
                          buildWhen: (previous, current) => current is! SignInActionsState,
                          builder: (context, state) {
                            Widget child() {
                              return switch (state) {
                                SignInWithProviders() => const ProvidersSignIn(),
                                _ => const SizedBox(),
                              };
                            }

                            return AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: child());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
