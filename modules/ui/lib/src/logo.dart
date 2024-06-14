import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'WASTY',
          style: GoogleFonts.abel(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).extension<CustomColors>()?.logodark,
          ),
        ),
        Text(
          'Your recycling assistant',
          style: GoogleFonts.kufam(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).extension<CustomColors>()?.logolight,
          ),
        ),
      ],
    );
  }
}
