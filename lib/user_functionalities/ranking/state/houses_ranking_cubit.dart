import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/future_extension.dart';
import '../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../common_functionalities/models/house.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_house_use_case.dart';
import '../../quests/use_cases/is_ranking_freezed_use_case.dart';
import '../use_cases/get_houses_use_case.dart';

part 'houses_ranking_state.dart';

@injectable
class HousesRankingCubit extends Cubit<HousesRankingState> {
  HousesRankingCubit(
    this._getHousesUseCase,
    this._getSignedUserHouseUseCase,
    this._isRankingFreezedUseCase,
  ) : super(const HousesRankingLoading());

  final GetHousesUseCase _getHousesUseCase;
  final GetSignedUserHouseUseCase _getSignedUserHouseUseCase;
  final IsRankingFreezedUseCase _isRankingFreezedUseCase;

  void init() {
    _isRankingFreezedUseCase().actions(
      progress: () => emit(const HousesRankingLoading()),
      failure: (_) => emit(const HousesRankingFailure(null)),
      success: (rankingFreezed) {
        if (rankingFreezed) {
          emit(const HousesRankingFreezed());
        } else {
          loadHouses();
        }
      },
    );
  }

  Future<void> loadHouses() async {
    if (state.userHouse == null) {
      await _getSignedUserHouseUseCase().actions(
        progress: () => emit(const HousesRankingLoading()),
        success: (userHouse) => emit(HousesRankingLoading(userHouse)),
        failure: (_) => emit(const HousesRankingFailure(null)),
      );
    }
    _getHousesUseCase().actions(
      progress: () => emit(HousesRankingLoading(state.userHouse)),
      success: (houses) => emit(HousesRankingLoaded(state.userHouse, houses: houses)),
      failure: (_) => emit(HousesRankingFailure(state.userHouse)),
    );
  }
}
