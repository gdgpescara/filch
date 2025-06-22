import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../ui.dart';

class ContainersSection extends StatelessWidget {
  const ContainersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(text: 'App Card'),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'light'),
        const Gap.vertical(Spacing.s),
        const AppCard(style: AppCardStyle.normal, child: SizedBox(width: double.infinity, height: 300)),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'dark'),
        const Gap.vertical(Spacing.s),
        const AppCard(
          style: AppCardStyle.normal,
          brightness: Brightness.dark,
          child: SizedBox(width: double.infinity, height: 300),
        ),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'with colored border'),
        const Gap.vertical(Spacing.s),
        const AppCard(
          style: AppCardStyle.normal,
          borderColor: Colors.red,
          child: SizedBox(width: double.infinity, height: 300),
        ),
        const Gap.vertical(Spacing.l),
        const Heading(text: 'Blur Container'),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'light'),
        const Gap.vertical(Spacing.s),
        const BlurContainer(child: SizedBox(width: double.infinity, height: 300)),
        const Gap.vertical(Spacing.m),
        const SubHeading(text: 'dark'),
        const Gap.vertical(Spacing.s),
        const BlurContainer(brightness: Brightness.dark, child: SizedBox(width: double.infinity, height: 300)),
        const Gap.vertical(Spacing.l),
        const Heading(text: 'Remove focus container'),
        const Gap.vertical(Spacing.m),
        RemoveFocusContainer(
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: Center(child: ReactiveTextField(formControl: FormControl<String>())),
          ),
        ),
      ],
    );
  }
}
