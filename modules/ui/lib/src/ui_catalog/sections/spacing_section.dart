import 'package:flutter/material.dart';

import '../../../ui.dart';

class SpacingSection extends StatelessWidget {
  const SpacingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Heading(text: 'Spacing'),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'none (0)'),
        _spaceBox(context, Spacing.none),
        const SubHeading(text: 'xs (4)'),
        _spaceBox(context, Spacing.xs),
        const SubHeading(text: 's (8)'),
        _spaceBox(context, Spacing.s),
        const SubHeading(text: 'm (16)'),
        _spaceBox(context, Spacing.m),
        const SubHeading(text: 'l (24)'),
        _spaceBox(context, Spacing.l),
        const SubHeading(text: 'xl (32)'),
        _spaceBox(context, Spacing.xl),
        const SubHeading(text: 'xxl (40)'),
        _spaceBox(context, Spacing.xxl),
        const SubHeading(text: 'xxxl (48)'),
        _spaceBox(context, Spacing.xxxl),
      ],
    );
  }

  Widget _spaceBox(BuildContext context, double spacing) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: SizedBox(height: spacing, width: double.infinity),
    );
  }
}
