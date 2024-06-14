import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap.vertical(this.height, {super.key}): width = null;
  const Gap.horizontal(this.width, {super.key}): height = null;

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
