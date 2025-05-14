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
    this.border,
    this.style = BlurContainerStyle.normal,
  });

  final Widget child;
  final BorderRadius? clipRadius;
  final Brightness brightness;
  final Border? border;
  final BlurContainerStyle style;

  @override
  Widget build(BuildContext context) {
    Widget shadowed(Widget child) {
      return DecoratedBox(
        decoration: OuterShadowDecoration(
          color: border?.top.color ??
              border?.left.color ??
              border?.right.color ??
              border?.bottom.color ??
              context.colorScheme.primary,
          radius: clipRadius ?? BorderRadius.zero,
          blurRadius: 5,
        ),
        child: child,
      );
    }

    final blurContainer = ClipRRect(
      borderRadius: clipRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: border,
            borderRadius: clipRadius ?? BorderRadius.zero,
            color: context.colorScheme.surface.withValues(alpha: .7),
          ),
          child: child,
        ),
      ),
    );

    return switch (style) {
      BlurContainerStyle.normal => blurContainer,
      BlurContainerStyle.shadowed => shadowed(blurContainer),
    };
  }
}

enum BlurContainerStyle {
  normal,
  shadowed;
}
