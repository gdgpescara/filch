import 'dart:io';

import 'package:flutter/material.dart';

import '../models/providers_enum.dart';
import 'sign_in_button.dart';

class ProvidersSignIn extends StatelessWidget {
  const ProvidersSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ProvidersEnum.values
          .where((p) => (p != ProvidersEnum.apple || Platform.isIOS) && (p != ProvidersEnum.emailPassword))
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SignInButton(provider: e),
            ),
          )
          .toList(),
    );
  }
}
