import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'management_state.dart';

@injectable
class ManagementCubit extends SafeEmitterCubit<ManagementState> {
  ManagementCubit(this._getAssignablePointsUseCase, this._getQuestsUseCase) : super(const ManagementLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;
  final GetSignedUserQuestsUseCase _getQuestsUseCase;

  void load() {
    _getAssignablePointsUseCase().when(
      progress: () => emit(const ManagementLoading()),
      error: (_) => emit(const ManagementFailure()),
      success: (points) {
        final currentState = state;
        if (currentState is ManagementLoaded) {
          emit(currentState.copyWith(points: points));
        } else {
          emit(ManagementLoaded(points: points));
        }
      },
    );

    _getQuestsUseCase().when(
      progress: () => emit(const ManagementLoading()),
      error: (_) => emit(const ManagementFailure()),
      success: (quests) {
        final currentState = state;
        if (currentState is ManagementLoaded) {
          emit(currentState.copyWith(quests: quests));
        } else {
          emit(ManagementLoaded(quests: quests));
        }
      },
    );
  }
}
