import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class AssignTShirt extends StatelessWidget {
  const AssignTShirt(this.navigateToTShirtAssignment, {super.key});

  final VoidCallback navigateToTShirtAssignment;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(RadiusSize.m),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(onPressed: navigateToTShirtAssignment, child: Text(t.staff.t_shirt_assignment.label)),
      ),
    );
  }
}
