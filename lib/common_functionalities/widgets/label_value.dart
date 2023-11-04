import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelValue extends StatelessWidget {
  const LabelValue({super.key, required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8, width: double.infinity),
        Text(
          value ?? ' - ',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
