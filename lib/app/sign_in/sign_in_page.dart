import 'package:auth/auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return auth.SignInPage(
      signButtonBuilder: (signInButtons) {
        return Background(
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
                const SizedBox(height: Spacing.xxl),
                Flexible(child: signInButtons),
              ],
            ),
          ),
        );
      },
    );
  }
}
