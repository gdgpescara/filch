import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
