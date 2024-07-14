import 'package:flutter/material.dart';

import '../../../ui.dart';

class RadiusSection extends StatelessWidget {
  const RadiusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Heading(text: 'RadiusSize'),
        const Gap.vertical(RadiusSize.m),
        const SubHeading(text: 'none (0)'),
        _spaceBox(context, RadiusSize.none),
        const SubHeading(text: 's (2)'),
        _spaceBox(context, RadiusSize.s),
        const SubHeading(text: 'm (8)'),
        _spaceBox(context, RadiusSize.m),
        const SubHeading(text: 'l (16)'),
        _spaceBox(context, RadiusSize.l),
        const SubHeading(text: 'xl (24)'),
        _spaceBox(context, RadiusSize.xl),
      ],
    );
  }

  Widget _spaceBox(BuildContext context, double radius) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.onSurface),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(height: 50, width: double.infinity),
    );
  }
}
