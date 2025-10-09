import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class SuggestionItemWidget extends StatelessWidget {
  const SuggestionItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(RadiusSize.s),
            ),
            child: Icon(
              icon,
              size: 16,
              color: context.colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(width: Spacing.s),
          Expanded(
            child: Text(text, style: context.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
