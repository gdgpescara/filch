import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../common_functionalities/models/assignable_points.dart';
import '../../../common_functionalities/user/use_cases/get_assignable_points_use_case.dart';
import '../../../user_functionalities/quests/models/quest.dart';
import '../../../user_functionalities/quests/use_cases/get_signed_user_quests_use_case.dart';

part 'scan_state.dart';

@injectable
class ScanCubit extends Cubit<ScanState> {
  ScanCubit(
    this._getAssignablePointsUseCase,
    this._getQuestsUseCase,
  ) : super(const ScanLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;
  final GetSignedUserQuestsUseCase _getQuestsUseCase;

  void load() {
    _getAssignablePointsUseCase().actions(
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

    _getQuestsUseCase().actions(
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
