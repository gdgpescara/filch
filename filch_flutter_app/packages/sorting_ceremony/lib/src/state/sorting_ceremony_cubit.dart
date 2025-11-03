import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../sorting_ceremony.dart';
import '../use_cases/get_team_use_case.dart';

part 'sorting_ceremony_state.dart';

@injectable
class SortingCeremonyCubit extends SafeEmitterCubit<SortingCeremonyState> {
  SortingCeremonyCubit(
    this._assignTeamUseCase,
    this._getTeamUseCase,
  ) : super(SortingCeremonyLoading());

  final AssignTeamUseCase _assignTeamUseCase;
  final GetTeamUseCase _getTeamUseCase;
  
  Future<void> startSortingCeremony() async {
    await Future<void>.delayed(const Duration(seconds: 4));
    await _assignTeamUseCase().when(
      progress: () => emit(SortingCeremonyLoading()),
      success: (teamId) async {
        final team = await _getTeamUseCase(teamId);
        if (team == null) {
          emit(const SortingCeremonyFailure(failure: 'Team not found'));
          return;
        }
        emit(SortingCeremonySuccess(team: team));
      },
      error: (failure) {
        if (failure.code == 'already-exists') {
          emit(SortingCeremonyFinish());
        } else {
          emit(SortingCeremonyFailure(failure: failure.message));
        }
      },
    );
  }

  void exitCeremony() {
    emit(SortingCeremonyFinish());
  }
}
