import 'package:flutter/material.dart';

import '../../ui.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.borderColor, this.brightness = Brightness.light});

  final Widget child;
  final Color? borderColor;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(RadiusSize.l),
      brightness: brightness,
      child: Container(
        padding: const EdgeInsets.all(Spacing.l),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.l),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: child,
      ),
    );
  }
}
