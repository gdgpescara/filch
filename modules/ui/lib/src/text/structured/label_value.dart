import 'package:flutter/material.dart';

import '../../../ui.dart';

class LabelValue extends StatelessWidget {
  const LabelValue({super.key, required this.label, this.value, this.disposition = Disposition.column});

  final String label;
  final String? value;
  final Disposition disposition;

  @override
  Widget build(BuildContext context) {
    return switch(disposition) {
      Disposition.row => _buildRow(context),
      Disposition.column => _buildColumn(context),
    };
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap.horizontal(Spacing.xs),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              value ?? ' - ',
              style: context.textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        // const Gap.vertical(Spacing.xs),
        SizedBox(
          width: double.infinity,
          child: Text(
            value ?? ' - ',
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

enum Disposition {
  row,
  column;
}
