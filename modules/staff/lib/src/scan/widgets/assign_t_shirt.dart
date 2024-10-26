import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class AssignTShirt extends StatelessWidget {
  const AssignTShirt(
    this.navigateToTShirtAssignment, {
    super.key,
  });

  final VoidCallback navigateToTShirtAssignment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: navigateToTShirtAssignment,
      contentPadding: EdgeInsets.zero,
      iconColor: Colors.white,
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(
        t.staff.t_shirt_assignment.label,
        style: context
            .getTextTheme(TextThemeType.monospace)
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
