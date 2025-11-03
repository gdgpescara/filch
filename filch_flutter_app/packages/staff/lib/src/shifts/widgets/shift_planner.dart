import 'package:auth/auth.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:time_planner/time_planner.dart';
import 'package:ui/ui.dart';

import '../models/shift.dart';
import 'shift_planner_task.dart';

class ShiftPlanner extends StatelessWidget {
  const ShiftPlanner({super.key, required this.shifts});

  final List<Shift> shifts;

  @override
  Widget build(BuildContext context) {
    final groupedShiftsByUser = groupBy(shifts, (shift) => shift.user.uid);
    if (groupedShiftsByUser.isEmpty) {
      return Center(child: Text(t.staff.shifts.empty));
    }
    return TimePlanner(
      startHour: 8,
      endHour: 23,
      use24HourFormat: true,
      currentTimeAnimation: true,
      style: TimePlannerStyle(
        cellWidth: (MediaQuery.of(context).size.width * .4).toInt(),
        dividerColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: .5),
        cellHeight: 100,
      ),
      headers: _headers(context, groupedShiftsByUser),
      tasks: _mapTasks(groupedShiftsByUser),
    );
  }

  List<TimePlannerTitle> _headers(BuildContext context, Map<String?, List<Shift>> groupedShiftsByUser) {
    final loggedUserUid = GetIt.I<GetSignedUserUseCase>()()?.uid;
    final myShifts = groupedShiftsByUser.entries.firstWhereOrNull((e) => e.key == loggedUserUid);
    return [
      // logged user header
      if (myShifts != null)
        TimePlannerTitle(
          title: t.staff.shifts.me,
          titleStyle: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ...groupedShiftsByUser.entries.whereNot((e) => e.key == loggedUserUid).map((entry) {
        return TimePlannerTitle(
          title: entry.value.first.user.displayName ?? ' - ',
          titleStyle: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        );
      }),
    ];
  }

  List<TimePlannerTask> _mapTasks(Map<String?, List<Shift>> groupedShiftsByUser) {
    final loggedUserUid = GetIt.I<GetSignedUserUseCase>()()?.uid;
    final myShifts = groupedShiftsByUser.entries.firstWhereOrNull((e) => e.key == loggedUserUid);
    return [
      // logged user header
      if (myShifts != null) ...myShifts.value.map((shift) => ShiftPlannerTask(shift: shift, position: 0)),
      ...groupedShiftsByUser.entries
          .whereNot((e) => e.key == loggedUserUid)
          .mapIndexed((index, entry) => entry.value.map((shift) => ShiftPlannerTask(shift: shift, position: index + 1)))
          .expand((element) => element),
    ];
  }
}
