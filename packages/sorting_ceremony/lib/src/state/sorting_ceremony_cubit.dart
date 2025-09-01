import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../sorting_ceremony.dart';

part 'sorting_ceremony_state.dart';

@injectable
class SortingCeremonyCubit extends SafeEmitterCubit<SortingCeremonyState> {
  SortingCeremonyCubit(this._assignTeamUseCase) : super(SortingCeremonyLoading());

  final AssignTeamUseCase _assignTeamUseCase;

  Future<void> startSortingCeremony() async {
    await Future<void>.delayed(const Duration(seconds: 10));
    await _assignTeamUseCase().when(
      progress: () => emit(SortingCeremonyLoading()),
      success: (house) async {
        emit(SortingCeremonySuccess(house: house));
        await Future<void>.delayed(const Duration(seconds: 15));
        emit(SortingCeremonyFinish());
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
}
