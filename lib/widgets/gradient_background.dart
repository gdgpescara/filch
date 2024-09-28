import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui/ui.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return DecoratedBox(
    //   // decoration: BoxDecoration(
    //   //   gradient: LinearGradient(
    //   //     colors: [context.colorScheme.surface, context.colorScheme.surfaceBright],
    //   //     begin: Alignment.bottomRight,
    //   //     end: Alignment.topLeft,
    //   //   ),
    //   // ),
    //   child: child,
    // );
    return Material(
      color: context.colorScheme.surface,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'images/background.svg',
              package: 'assets',
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              excludeFromSemantics: true,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
