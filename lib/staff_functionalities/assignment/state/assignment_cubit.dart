import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/future_extension.dart';
import '../../../common_functionalities/models/points_type_enum.dart';
import '../../../common_functionalities/use_cases/assign_points_use_case.dart';

part 'assignment_state.dart';

@injectable
class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit(this._assignPointsUseCase) : super(const AssignmentInitial());

  final AssignPointsUseCase _assignPointsUseCase;

  void onQrCodesScanned(List<String> values) {
    final actualValues = state is AssignmentInitial ? (state as AssignmentInitial).scannedUsers : <String>[];
    emit(AssignmentInitial({...actualValues, ...values}.toList()));
  }

  Future<void> assign({
    int? points,
    String? quest,
    required PointsTypeEnum type,
    required List<String> users,
  }) async {
    _assignPointsUseCase(points: points ?? 0, users: users, quest: quest, pointsType: type).actions(
      progress: () => emit(const Assigning()),
      success: (_) => emit(const Assigned()),
      failure: (_) => emit(const AssignFailure()),
    );
  }
}
