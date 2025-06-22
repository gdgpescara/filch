import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../ui.dart';

class ConfettiContainer extends StatefulWidget {
  const ConfettiContainer({super.key, required this.child});

  final Widget child;

  @override
  State<ConfettiContainer> createState() => _ConfettiContainerState();
}

class _ConfettiContainerState extends State<ConfettiContainer> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 10))..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    const degreesPerStep = 360 / numberOfPoints;
    const halfDegreesPerStep = degreesPerStep / 2;
    final path =
        Path()
          ..moveTo(halfWidth + externalRadius * cos(degToRad(-90)), halfWidth + externalRadius * sin(degToRad(-90)));

    for (var i = 0; i < numberOfPoints; i++) {
      final externalAngle = degToRad(-90 + i * degreesPerStep);
      final internalAngle = degToRad(-90 + i * degreesPerStep + halfDegreesPerStep);

      path
        ..lineTo(halfWidth + externalRadius * cos(externalAngle), halfWidth + externalRadius * sin(externalAngle))
        ..lineTo(halfWidth + internalRadius * cos(internalAngle), halfWidth + internalRadius * sin(internalAngle));
    }

    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(alignment: Alignment.centerRight, child: _buildConfettiWidget(-0.6 * pi)),
        Align(alignment: Alignment.centerLeft, child: _buildConfettiWidget(-0.3 * pi)),
      ],
    );
  }

  ConfettiWidget _buildConfettiWidget(double blastDirection) {
    return ConfettiWidget(
      confettiController: _controller,
      blastDirection: blastDirection,
      shouldLoop: true,
      colors: [
        appColors.googleYellow.seed,
        appColors.googleBlue.seed,
        appColors.googleGreen.seed,
        appColors.googleRed.seed,
      ],
      createParticlePath: drawStar,
    );
  }
}
