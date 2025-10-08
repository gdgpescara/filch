import 'package:flutter/material.dart';


/// Custom clipper that creates a trapezoidal button shape
/// based on the provided SVG path
class TappableAreaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Convert the original SVG coordinates to relative coordinates (0-1)
    // Original path: M581.163 697.531L931.163 660.5L915.14 793.5H589.175L581.163 697.531Z

    // Scale to the button size
    final width = size.width;
    final height = size.height;

    // Start point (bottom left, lower than right)
    path
      ..moveTo(0, height * 0.25)
      // Top right (higher than left)
      ..lineTo(width, 0)
      // Bottom right corner
      ..lineTo(width - 5, height)
      // Bottom left corner
      ..lineTo(5, height)
      // Close the path back to start
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
