import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../common_functionalities/models/assignable_points.dart';
import '../../../common_functionalities/user/use_cases/get_assignable_points_use_case.dart';

part 'scan_state.dart';

@injectable
class ScanCubit extends Cubit<ScanState> {
  ScanCubit(this._getAssignablePointsUseCase) : super(const ScanLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;

  void load() {
    _getAssignablePointsUseCase().actions(
      progress: () => emit(const ScanLoading()),
      failure: (_) => emit(const ScanFailure()),
      success: (points) => emit(ScanLoaded(points)),
    );
  }
}
