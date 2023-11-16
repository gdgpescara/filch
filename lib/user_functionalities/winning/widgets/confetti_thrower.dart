import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiThrower extends StatelessWidget {
  const ConfettiThrower({
    required this.controller,
    super.key,
  });

  final ConfettiController controller;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      maximumSize: const Size(10, 10),
      minimumSize: const Size(5, 5),
      confettiController: controller,
      numberOfParticles: 350,
      maxBlastForce: 150,
      minBlastForce: 70,
      blastDirectionality: BlastDirectionality.explosive,
    );
  }
}
