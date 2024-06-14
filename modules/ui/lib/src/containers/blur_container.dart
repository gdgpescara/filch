import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({super.key, required this.child, this.clipRadius, this.brightness = Brightness.light});

  final Widget child;
  final BorderRadius? clipRadius;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: clipRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          alignment: Alignment.center,
          color: (brightness == Brightness.light ? Colors.white : Colors.black).withOpacity(.10),
          child: child,
        ),
      ),
    );
  }
}
