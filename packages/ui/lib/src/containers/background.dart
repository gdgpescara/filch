import 'package:flutter/material.dart';

import '../../ui.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'images/background.png',
                package: 'assets',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                excludeFromSemantics: true,
                filterQuality: FilterQuality.low,
                isAntiAlias: true,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
