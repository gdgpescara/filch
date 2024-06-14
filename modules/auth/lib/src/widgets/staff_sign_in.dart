import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../models/providers_enum.dart';
import '../state/sign_in_cubit.dart';
import 'sign_in_button.dart';

class StaffSignIn extends StatefulWidget {
  const StaffSignIn({super.key});

  @override
  State<StaffSignIn> createState() => _StaffSignInState();
}

class _StaffSignInState extends State<StaffSignIn> {
  final _form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReactiveTextField<String>(
              formControlName: 'email',
              decoration: InputDecoration(
                labelText: t.auth.staff_sign_in.email,
              ),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.username],
            ),
            const SizedBox(height: 8),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
              decoration: InputDecoration(
                labelText: t.auth.staff_sign_in.password,
              ),
              keyboardType: TextInputType.visiblePassword,
              autofillHints: const [AutofillHints.password],
            ),
            const SizedBox(height: 16),
            SignInButton(
              onPressed: () {
                if (_form.valid) {
                  context.read<SignInCubit>().emailPasswordSignIn(_form.value);
                }
              },
              provider: ProvidersEnum.emailPassword,
            ),
          ],
        ),
      ),
    );
  }
}
