import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({super.key, required this.child, this.clipRadius});

  final Widget child;
  final BorderRadius? clipRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: clipRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          alignment: Alignment.center,
          color: Colors.white.withOpacity(.10),
          child: child,
        ),
      ),
    );
  }
}
