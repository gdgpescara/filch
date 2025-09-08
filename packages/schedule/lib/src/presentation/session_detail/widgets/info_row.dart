import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: context.colorScheme.primary,
        ),
        const SizedBox(width: Spacing.s),
        Text(
          '$label: ',
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
