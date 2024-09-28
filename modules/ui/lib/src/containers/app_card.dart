import 'package:flutter/material.dart';

import '../../ui.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.borderColor,
    this.brightness = Brightness.light,
    this.padding = const EdgeInsets.all(Spacing.l),
  });

  final Widget child;
  final Color? borderColor;
  final EdgeInsets padding;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(RadiusSize.l),
      brightness: brightness,
      borderColor: borderColor ?? context.colorScheme.primaryContainer,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
