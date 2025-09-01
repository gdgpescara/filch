import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:staff/staff.dart';

class TShirtAssignmentPage extends StatelessWidget {
  const TShirtAssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TShirtAssignment(onDone: Routefly.pop<void>);
  }
}
