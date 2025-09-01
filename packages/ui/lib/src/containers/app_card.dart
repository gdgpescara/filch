import 'package:flutter/material.dart';

import '../../ui.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.borderColor,
    this.brightness = Brightness.light,
    this.radius,
    this.padding = const EdgeInsets.all(Spacing.l),
    required this.style,
  });

  final Widget child;
  final Color? borderColor;
  final EdgeInsets padding;
  final Brightness brightness;
  final double? radius;
  final AppCardStyle style;

  @override
  Widget build(BuildContext context) {
    final radius =
        this.radius ??
        switch (style) {
          AppCardStyle.normal => RadiusSize.m,
          AppCardStyle.bordered => RadiusSize.m,
          AppCardStyle.caption => RadiusSize.s,
        };
    return BlurContainer(
      clipRadius: BorderRadius.circular(radius),
      brightness: brightness,
      border: switch (style) {
        AppCardStyle.normal => null,
        AppCardStyle.bordered => Border.all(color: borderColor ?? context.colorScheme.primaryContainer),
        AppCardStyle.caption => Border(
          top: BorderSide(color: borderColor ?? context.colorScheme.primaryContainer, width: radius * .038),
          left: BorderSide(color: borderColor ?? context.colorScheme.primaryContainer, width: radius),
          right: BorderSide(color: borderColor ?? context.colorScheme.primaryContainer, width: radius * .038),
          bottom: BorderSide(color: borderColor ?? context.colorScheme.primaryContainer, width: radius * .038),
        ),
      },
      child: Padding(padding: padding, child: child),
    );
  }
}

enum AppCardStyle { bordered, normal, caption }
