import 'package:flutter/material.dart';

class OuterShadowDecoration extends Decoration {
  const OuterShadowDecoration({this.color = Colors.black, this.radius = BorderRadius.zero, this.blurRadius = 8});

  final Color color;
  final BorderRadius radius;
  final double blurRadius;

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) => _OuterShadowBoxPainter(color, blurRadius, radius);
}

class _OuterShadowBoxPainter extends BoxPainter {
  _OuterShadowBoxPainter(this.color, this.blurRadius, this.radius);

  final Color color;
  final BorderRadius radius;
  final double blurRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final paint =
        Paint()
          ..color = color
          ..maskFilter = MaskFilter.blur(BlurStyle.outer, blurRadius);

    final path =
        Path()..addRRect(
          RRect.fromRectAndCorners(
            rect,
            topLeft: radius.topLeft,
            topRight: radius.topRight,
            bottomLeft: radius.bottomLeft,
            bottomRight: radius.bottomRight,
          ),
        );
    canvas.drawPath(path, paint);
  }
}
