import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'assignment_state.dart';

@injectable
class AssignmentCubit extends SafeEmitterCubit<AssignmentState> {
  AssignmentCubit(this._assignPointsUseCase) : super(const AssignmentInitial());

  final AssignPointsUseCase _assignPointsUseCase;

  void onQrCodesScanned(List<String> values) {
    final actualValues = state is AssignmentInitial ? (state as AssignmentInitial).scannedUsers : <String>[];
    emit(AssignmentInitial({...actualValues, ...values}.toList()));
  }

  Future<void> assign({int? points, String? quest, required PointsTypeEnum type, required List<String> users}) async {
    final currentState = state;
    await _assignPointsUseCase(points: points ?? 0, users: users, quest: quest, pointsType: type).when(
      progress: () => emitAction(currentState, const Assigning()),
      success: (_) => emitAction(currentState, const Assigned()),
      error: (_) => emitAction(currentState, const AssignFailure()),
    );
  }

  void emitAction(AssignmentState state, AssignmentState actionState) {
    emit(actionState);
    emit(state);
  }
}
