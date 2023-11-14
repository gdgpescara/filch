import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/future_extension.dart';
import '../../../common_functionalities/models/house_detail.dart';
import '../use_cases/get_winner_house_use_case.dart';

part 'winner_house_state.dart';

@injectable
class WinnerHouseCubit extends Cubit<WinnerHouseState> {
  WinnerHouseCubit(this._getWinnerHouseUseCase) : super(const WinnerHouseLoading());

  final GetWinnerHouseUseCase _getWinnerHouseUseCase;

  void loadHouse() {
    _getWinnerHouseUseCase().actions(
      progress: () => emit(const WinnerHouseLoading()),
      success: (house) => emit(WinnerHouseLoaded(house: house)),
      failure: (_) => emit(const WinnerHouseFailure()),
    );
  }
}
