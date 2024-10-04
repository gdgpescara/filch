import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'scan_state.dart';

@injectable
class ScanCubit extends SafeEmitterCubit<ScanState> {
  ScanCubit(
    this._getAssignablePointsUseCase,
    this._getQuestsUseCase,
  ) : super(const ScanLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;
  final GetSignedUserQuestsUseCase _getQuestsUseCase;

  void load() {
    _getAssignablePointsUseCase().when(
      progress: () => emit(const ScanLoading()),
      failure: (_) => emit(const ScanFailure()),
      success: (points) {
        final currentState = state;
        if (currentState is ScanLoaded) {
          emit(currentState.copyWith(points: points));
        } else {
          emit(ScanLoaded(points: points));
        }
      },
    );

    _getQuestsUseCase().when(
      progress: () => emit(const ScanLoading()),
      failure: (_) => emit(const ScanFailure()),
      success: (quests) {
        final currentState = state;
        if (currentState is ScanLoaded) {
          emit(currentState.copyWith(quests: quests));
        } else {
          emit(ScanLoaded(quests: quests));
        }
      },
    );
  }
}
