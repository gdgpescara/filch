import 'package:flutter/material.dart';

import '../../ui.dart';
import 'sections/app_colors_section.dart';
import 'sections/containers_section.dart';
import 'sections/radius_section.dart';
import 'sections/spacing_section.dart';
import 'sections/typography_section.dart';

class UiCatalog extends StatelessWidget {
  const UiCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(Spacing.l).copyWith(
          top: MediaQuery.of(context).viewPadding.top + Spacing.l,
          bottom: MediaQuery.of(context).viewPadding.bottom + Spacing.l,
        ),
        children: const [
          TypographySection(),
          ..._space,
          SpacingSection(),
          ..._space,
          RadiusSection(),
          ..._space,
          AppColorsSection(),
          ..._space,
          ContainersSection(),
          ..._space,
        ],
      ),
    );
  }

  static const List<Widget> _space = [
      Gap.vertical(Spacing.l),
      Divider(),
      Gap.vertical(Spacing.l),
    ];
}
