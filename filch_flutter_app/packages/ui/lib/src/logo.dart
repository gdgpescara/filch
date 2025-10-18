import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n/i18n.dart';

import '../ui.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'logo/logo.svg',
          package: 'assets',
          height: 100,
          semanticsLabel: t.devfest.semantic.logo_dev_fest,
        ),
        const Gap.vertical(Spacing.xs),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.poppins(
              height: 0.9,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: context.colorScheme.onSurface,
            ),
            children: [
              const TextSpan(text: 'DEVFEST\n'),
              TextSpan(
                text: 'PESCARA',
                style: TextStyle(color: context.colorScheme.secondary),
              ),
              const TextSpan(text: ' 2025'),
            ],
          ),
        ),
      ],
    );
  }
}
