import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/providers_enum.dart';
import '../state/sign_in_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.provider, this.onPressed});

  final ProvidersEnum provider;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            LoaderOverlay.show(context);
            return onPressed?.call();
          }
          context.read<SignInCubit>().providerSignIn(provider);
        },
        child: Text(
          _providerName,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  String get _providerName => {
    ProvidersEnum.google: t.auth.sign_in_providers.google,
    ProvidersEnum.apple: t.auth.sign_in_providers.apple,
    ProvidersEnum.emailPassword: t.auth.staff_sign_in.sign_in,
  }[provider]!;
}
