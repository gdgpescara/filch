// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:schedule/schedule.dart' as schedule;

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Routefly.query['id'];
    if (id == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Routefly.pop<void>(context);
      });
      return const SizedBox.shrink();
    }
    return schedule.SessionDetailPage(sessionId: id.toString());
  }
}
