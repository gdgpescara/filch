import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:rive/rive.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: t.common.semantics.loading,
      child: const SizedBox(
        width: double.infinity,
        height: 50,
        child: RiveAnimation.asset(
          'packages/assets/loader_animation.riv',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
