import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../i18n/strings.g.dart';
import '../domain/models/providers_enum.dart';
import '../state/sign_in_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.provider, this.onPressed});

  final ProvidersEnum provider;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          return onPressed?.call();
        }
        context.read<SignInCubit>().providerSignIn(provider);
      },
      child: _child(provider),
    );
  }

  Widget _child(ProvidersEnum provider) {
    return Row(
      children: [
        // _providerIcon(provider),
        // const SizedBox(width: 16),
        Expanded(child: Text(_providerName, textAlign: TextAlign.center)),
        const SizedBox(width: 16),
        _providerLoading,
      ],
    );
  }

  Widget get _providerLoading => BlocSelector<SignInCubit, SignInState, bool>(
        selector: (state) => state is SignInLoading && state.provider == provider,
        builder: (context, showLoader) {
          return showLoader
              ? const SizedBox(width: 10, height: 10, child: CircularProgressIndicator())
              : const SizedBox.shrink();
        },
      );

  String get _providerName => {
        ProvidersEnum.google: t.sign_in.sign_in_providers.google,
        ProvidersEnum.facebook: t.sign_in.sign_in_providers.facebook,
        ProvidersEnum.apple: t.sign_in.sign_in_providers.apple,
        ProvidersEnum.twitter: t.sign_in.sign_in_providers.twitter,
        ProvidersEnum.emailPassword: t.sign_in.staff_sign_in.sign_in,
      }[provider]!;
}
