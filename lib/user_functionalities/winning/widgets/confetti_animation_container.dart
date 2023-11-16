import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'confetti_thrower.dart';

class ConfettiAnimationContainer extends StatefulWidget {
  const ConfettiAnimationContainer({super.key, required this.child});

  final Widget child;

  @override
  State<ConfettiAnimationContainer> createState() => _ConfettiAnimationContainerState();
}

class _ConfettiAnimationContainerState extends State<ConfettiAnimationContainer> {
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConfettiThrower(controller: _confettiController),
              ConfettiThrower(controller: _confettiController),
            ],
          ),
        ),
      ],
    );
  }
}
