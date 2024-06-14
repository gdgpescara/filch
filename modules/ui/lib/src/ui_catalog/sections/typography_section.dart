import 'package:flutter/material.dart';

import '../../../ui.dart';

class TypographySection extends StatelessWidget {
  const TypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(text: 'Typography'),
        Gap.vertical(Spacing.m),
        Heading(text: 'Heading'),
        Gap.vertical(Spacing.s),
        SubHeading(text: 'Sub Heading'),
        Gap.vertical(Spacing.s),
        Paragraph(
          text:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eget nisl. Donec auctor, nisl eget ultricies aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eget nisl.',
        ),
        Gap.vertical(Spacing.s),
        Caption(text: 'Mr. John Doe'),
      ],
    );
  }
}
