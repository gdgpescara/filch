import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_planner/time_planner.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../models/shift.dart';
import 'shift_planner_task.dart';

class ShiftPlanner extends StatelessWidget {
  const ShiftPlanner({super.key, required this.shifts});

  final List<Shift> shifts;

  @override
  Widget build(BuildContext context) {
    final groupedShiftsByUser = groupBy(shifts, (shift) => shift.user.uid);
    if (groupedShiftsByUser.isEmpty) {
      return Center(child: Text(t.shifts.empty));
    }
    return TimePlanner(
      startHour: 8,
      endHour: 23,
      use24HourFormat: true,
      currentTimeAnimation: true,
      style: TimePlannerStyle(
        cellWidth: (MediaQuery.of(context).size.width * .4).toInt(),
        dividerColor: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
        cellHeight: 100,
      ),
      headers: _headers(groupedShiftsByUser),
      tasks: _mapTasks(groupedShiftsByUser),
    );
  }

  List<TimePlannerTitle> _headers(Map<String?, List<Shift>> groupedShiftsByUser) {
    final loggedUserUid = injector<GetSignedUserUseCase>()()?.uid;
    final myShifts = groupedShiftsByUser.entries.firstWhereOrNull((e) => e.key == loggedUserUid);
    return [
      // logged user header
      if (myShifts != null)
        TimePlannerTitle(
          title: t.shifts.me,
          titleStyle: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
        ),
      ...groupedShiftsByUser.entries.whereNot((e) => e.key == loggedUserUid).map((entry) {
        return TimePlannerTitle(
          title: entry.value.first.user.displayName ?? ' - ',
          titleStyle: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
        );
      }),
    ];
  }

  List<TimePlannerTask> _mapTasks(Map<String?, List<Shift>> groupedShiftsByUser) {
    final loggedUserUid = injector<GetSignedUserUseCase>()()?.uid;
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
