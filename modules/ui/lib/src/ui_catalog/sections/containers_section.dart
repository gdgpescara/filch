import 'package:flutter/material.dart';

import '../../../ui.dart';

class ContainersSection extends StatelessWidget {
  const ContainersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(text: 'App Card'),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'light'),
        Gap.vertical(Spacing.s),
        AppCard(
          child: SizedBox(width: double.infinity, height: 300),
        ),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'dark'),
        Gap.vertical(Spacing.s),
        AppCard(
          brightness: Brightness.dark,
          child: SizedBox(width: double.infinity, height: 300),
        ),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'with colored border'),
        Gap.vertical(Spacing.s),
        AppCard(
          borderColor: Colors.red,
          child: SizedBox(width: double.infinity, height: 300),
        ),
        Gap.vertical(Spacing.l),
        Heading(text: 'Blur Container'),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'light'),
        Gap.vertical(Spacing.s),
        BlurContainer(
          child: SizedBox(width: double.infinity, height: 300),
        ),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'dark'),
        Gap.vertical(Spacing.s),
        BlurContainer(
          brightness: Brightness.dark,
          child: SizedBox(width: double.infinity, height: 300),
        ),
        Gap.vertical(Spacing.l),
        Heading(text: 'Remove focus container'),
        Gap.vertical(Spacing.m),
        RemoveFocusContainer(
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: TextField(),
          ),
        ),
      ],
    );
  }
}
