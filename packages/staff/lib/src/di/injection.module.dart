//@GeneratedMicroModule;StaffPackageModule;package:staff/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:injectable/injectable.dart' as _i526;
import 'package:quests/quests.dart' as _i177;
import 'package:schedule/schedule.dart' as _i199;
import 'package:staff/src/assignment/state/assignment_cubit.dart' as _i156;
import 'package:staff/src/management/state/management_cubit.dart' as _i813;
import 'package:staff/src/schedule_delay/state/schedule_delay_cubit.dart'
    as _i553;
import 'package:staff/src/shifts/state/shifts_cubit.dart' as _i1034;
import 'package:staff/src/shifts/use_cases/get_filtered_shifts_use_case.dart'
    as _i119;
import 'package:staff/src/t_shirt_assignment/state/t_shirt_assignment_cubit.dart'
    as _i734;

class StaffPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i553.ScheduleDelayCubit>(
        () => _i553.ScheduleDelayCubit(gh<_i199.GetRoomsUseCase>()));
    gh.factory<_i813.ManagementCubit>(() => _i813.ManagementCubit(
          gh<_i177.GetAssignablePointsUseCase>(),
          gh<_i177.GetSignedUserQuestsUseCase>(),
        ));
    gh.lazySingleton<_i119.GetFilteredShiftsUseCase>(
        () => _i119.GetFilteredShiftsUseCase(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i156.AssignmentCubit>(
        () => _i156.AssignmentCubit(gh<_i177.AssignPointsUseCase>()));
    gh.factory<_i1034.ShiftsCubit>(
        () => _i1034.ShiftsCubit(gh<_i119.GetFilteredShiftsUseCase>()));
    gh.factory<_i734.TShirtAssignmentCubit>(
        () => _i734.TShirtAssignmentCubit(gh<_i177.AssignTShirtUseCase>()));
  }
}
