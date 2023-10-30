import 'package:flutter/material.dart';

import '../widgets/blur_container.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.borderColor});

  final Widget child;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: child,
      ),
    );
  }
}
