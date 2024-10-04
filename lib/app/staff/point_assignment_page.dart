import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:staff/staff.dart';

// ignore: strict_raw_type
Route routeBuilder(BuildContext context, RouteSettings settings) {
  return Routefly.defaultRouteBuilder(
    context,
    settings,
    PointAssignmentPage(args: settings.arguments! as AssignmentPageArgs,),
  );
}

class PointAssignmentPage extends StatelessWidget {
  const PointAssignmentPage({super.key, required this.args});

  final AssignmentPageArgs args;

  @override
  Widget build(BuildContext context) {
    return AssignmentPage(args: args);
  }
}
