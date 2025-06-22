import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('logo/logo.png', package: 'assets', height: 100, semanticLabel: t.devfest2024.semantic.logo),
      ],
    );
  }
}
