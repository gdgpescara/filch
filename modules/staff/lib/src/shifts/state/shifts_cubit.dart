import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../models/shift.dart';
import '../use_cases/get_filtered_shifts_use_case.dart';

part 'shifts_state.dart';

@injectable
class ShiftsCubit extends SafeEmitterCubit<ShiftsState> {
  ShiftsCubit(
    this._getFilteredShiftsUseCase,
  ) : super(const ShiftsLoading());

  final GetFilteredShiftsUseCase _getFilteredShiftsUseCase;

  void init() {
    _getFilteredShiftsUseCase().when(
      progress: () => emit(const ShiftsLoading()),
      success: (shifts) => emit(ShiftsLoaded(shifts)),
      failure: (_) => emit(const ShiftsFailure()),
    );
  }
}
