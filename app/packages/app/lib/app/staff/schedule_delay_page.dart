import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:staff/staff.dart' as staff;

class ScheduleDelayPage extends StatelessWidget {
  const ScheduleDelayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return staff.ScheduleDelayPage(onDone: Routefly.pop<void>);
  }
}
