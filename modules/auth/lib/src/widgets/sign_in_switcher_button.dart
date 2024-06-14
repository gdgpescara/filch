import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';

import '../state/sign_in_cubit.dart';

class SignInSwitcherButton extends StatelessWidget {
  const SignInSwitcherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<SignInCubit>().switchSignIn,
      child: BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => current is! SignInActionsState,
        builder: (context, state) {
          return Text(
            (state is SignInWithProviders ? t.auth.staff_sign_in.button : t.auth.sign_in_providers.button)
                .toUpperCase(),
          );
        },
      ),
    );
  }
}
