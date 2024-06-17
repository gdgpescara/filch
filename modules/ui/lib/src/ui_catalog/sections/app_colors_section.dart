import 'package:flutter/material.dart';

import '../../../ui.dart';

class AppColorsSection extends StatelessWidget {
  const AppColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'Colors'),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'Primary'),
        _colorBox(context, Theme.of(context).colorScheme.primary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Secondary'),
        _colorBox(context, Theme.of(context).colorScheme.secondary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Tertiary'),
        _colorBox(context, Theme.of(context).colorScheme.tertiary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Success'),
        _colorBox(context, Theme.of(context).extension<CustomColors>()!.sourceSuccess!),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Warning'),
        _colorBox(context, Theme.of(context).extension<CustomColors>()!.sourceWarning!),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Error'),
        _colorBox(context, Theme.of(context).extension<CustomColors>()!.sourceError!),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Text'),
        _colorBox(context, Theme.of(context).colorScheme.onSurface),
      ],
    );
  }

  Widget _colorBox(BuildContext context, Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const SizedBox(height: 50, width: double.infinity),
    );
  }
}