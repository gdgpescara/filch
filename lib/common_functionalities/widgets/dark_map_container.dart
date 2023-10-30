import 'package:flutter/material.dart';

class DarkMapContainer extends StatelessWidget {
  const DarkMapContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/old_map_dark.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
