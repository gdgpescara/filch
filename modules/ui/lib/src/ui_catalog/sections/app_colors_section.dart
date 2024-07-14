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
        _colorBox(context, context.colorScheme.primary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Secondary'),
        _colorBox(context, context.colorScheme.secondary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Tertiary'),
        _colorBox(context, context.colorScheme.tertiary),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Success'),
        _colorBox(context, context.appColors.success.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Warning'),
        _colorBox(context, context.appColors.warning.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Error'),
        _colorBox(context, context.appColors.error.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Text'),
        _colorBox(context, context.colorScheme.onSurface),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Google Yellow'),
        _colorBox(context, context.appColors.googleYellow.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Google Red'),
        _colorBox(context, context.appColors.googleRed.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Google Green'),
        _colorBox(context, context.appColors.googleGreen.seed),
        const Gap.vertical(Spacing.s),
        const SubHeading(text: 'Google Blue'),
        _colorBox(context, context.appColors.googleBlue.seed),
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
