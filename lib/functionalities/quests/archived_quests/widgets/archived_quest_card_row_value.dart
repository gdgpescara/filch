import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchivedQuestCardRowValue extends StatelessWidget {
  const ArchivedQuestCardRowValue({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold)),
        const SizedBox(width: 20),
        Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }
}
