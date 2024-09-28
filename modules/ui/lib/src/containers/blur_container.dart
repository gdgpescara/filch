import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'outer_shadow_decoration.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    super.key,
    required this.child,
    this.clipRadius,
    this.brightness = Brightness.light,
    this.borderColor = pinkColor,
  });

  final Widget child;
  final BorderRadius? clipRadius;
  final Brightness brightness;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: OuterShadowDecoration(
        color: borderColor,
        radius: clipRadius ?? BorderRadius.zero,
        blurRadius: 5,
      ),
      child: ClipRRect(
        borderRadius: clipRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: clipRadius ?? BorderRadius.zero,
              color: context.colorScheme.surface.withOpacity(0.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
