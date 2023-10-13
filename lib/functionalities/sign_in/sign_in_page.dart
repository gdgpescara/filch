import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection/dependency_injection.dart';
import '../_shared/widgets/logo.dart';
import 'domain/models/providers_enum.dart';
import 'state/sign_in_cubit.dart';
import 'widgets/provider_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const routeName = 'sign_in';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<SignInCubit>(
        create: (context) => injector(),
        child: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if(state is SignInSuccess) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Logo.light(),
                ...ProvidersEnum.values.map((e) => ProviderSignInButton(provider: e)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
