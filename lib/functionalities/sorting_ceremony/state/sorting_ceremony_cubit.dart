import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/future_extension.dart';
import '../domain/usa_cases/assign_house_use_case.dart';

part 'sorting_ceremony_state.dart';

@injectable
class SortingCeremonyCubit extends Cubit<SortingCeremonyState> {
  SortingCeremonyCubit(this._assignHouseUseCase) : super(SortingCeremonyLoading());

  final AssignHouseUseCase _assignHouseUseCase;

  Future<void> startSortingCeremony() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    _assignHouseUseCase().actions(
      progress: () => emit(SortingCeremonyLoading()),
      success: (house) async {
        emit(SortingCeremonySuccess(house: house.toUpperCase()));
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
