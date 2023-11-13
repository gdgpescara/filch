import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/future_extension.dart';
import '../usa_cases/assign_house_use_case.dart';

part 'sorting_ceremony_state.dart';

@injectable
class SortingCeremonyCubit extends Cubit<SortingCeremonyState> {
  SortingCeremonyCubit(this._assignHouseUseCase) : super(SortingCeremonyLoading());

  final AssignHouseUseCase _assignHouseUseCase;

  Future<void> startSortingCeremony() async {
    await Future<void>.delayed(const Duration(seconds: 10));
    await _assignHouseUseCase().actions(
      progress: () => emit(SortingCeremonyLoading()),
      success: (house) async {
        emit(SortingCeremonySuccess(house: house));
        await Future<void>.delayed(const Duration(seconds: 5));
        emit(SortingCeremonyFinish());
      },
      failure: (failure) {
        if (failure.code == 'already-exists') {
          emit(SortingCeremonyFinish());
        } else {
          emit(SortingCeremonyFailure(failure: failure.message));
        }
      },
    );
  }
}
