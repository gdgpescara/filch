import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'package:ui/ui.dart';

import '../models/shift.dart';

class ShiftPlannerTask extends TimePlannerTask {
  ShiftPlannerTask({super.key, required Shift shift, required int position})
    : super(
        color: shift.location.color,
        dateTime: TimePlannerDateTime(day: position, hour: shift.start.hour, minutes: shift.start.minute),
        minutesDuration: shift.duration,
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${shift.start.hour.toString().padLeft(2, '0')}:${shift.start.minute.toString().padLeft(2, '0')} - ${(shift.start.hour + shift.duration ~/ 60).toString().padLeft(2, '0')}:${(shift.start.minute + (shift.duration % 60)).toString().padLeft(2, '0')}',
                    style: context.getTextTheme(TextThemeType.monospace).labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shift.location.label,
                    style: context
                        .getTextTheme(TextThemeType.monospace)
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (shift.notes.isNotEmpty) Expanded(child: Text(shift.notes)),
                ],
              ),
            );
          },
        ),
      );
}
