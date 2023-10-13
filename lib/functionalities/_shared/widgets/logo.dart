import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo(this._src, {super.key});

  factory Logo.dark() => const Logo('assets/images/logo_dark.svg');

  factory Logo.light() => const Logo('assets/images/logo_light.svg');

  final String _src;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(_src);
  }
}
