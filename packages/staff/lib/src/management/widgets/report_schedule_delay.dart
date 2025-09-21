import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class ReportScheduleDelay extends StatelessWidget {
  const ReportScheduleDelay(this.navigateToScheduleDelayReporting, {super.key});

  final VoidCallback navigateToScheduleDelayReporting;

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      clipRadius: BorderRadius.circular(RadiusSize.m),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(onPressed: navigateToScheduleDelayReporting, child: Text(t.staff.schedule_delay.label)),
      ),
    );
  }
}
