import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../_shared/widgets/dark_map_container.dart';
import '../_shared/widgets/logo.dart';
import '../_shared/widgets/remove_focus_container.dart';
import 'state/sign_in_cubit.dart';
import 'widgets/providers_sign_in.dart';
import 'widgets/sign_in_switcher_button.dart';
import 'widgets/staff_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const routeName = 'sign_in';

  @override
  Widget build(BuildContext context) {
    return RemoveFocusContainer(
      child: WillPopScope(
        onWillPop: () async => false,
        child: BlocProvider<SignInCubit>(
          create: (context) => injector(),
          child: BlocListener<SignInCubit, SignInState>(
            listenWhen: (previous, current) => current is SignInActionsState,
            listener: (context, state) {
              if (state is SignInSuccess) {
                Navigator.pop(context);
              }
              if(state is SignInFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.commons.errors.generic),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: DarkMapContainer(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Logo.light(),
                      const SizedBox(height: 42),
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
                    ],
                  ),
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
