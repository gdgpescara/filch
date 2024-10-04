import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../quests.dart';

part 'ranking_state.dart';

@injectable
class RankingCubit extends SafeEmitterCubit<RankingState> {
  RankingCubit(
    this._getSignedUserUseCase,
    this._getRankingUseCase,
    this._getYourRankingUseCase,
    this._getYourRankingPositionUseCase,
    this._isRankingFreezedUseCase,
  ) : super(const RankingLoading());

  final GetSignedUserUseCase _getSignedUserUseCase;
  final GetRankingUseCase _getRankingUseCase;
  final GetYourRankingUseCase _getYourRankingUseCase;
  final GetYourRankingPositionUseCase _getYourRankingPositionUseCase;
  final IsRankingFreezedUseCase _isRankingFreezedUseCase;

  void init() {
    _isRankingFreezedUseCase().when(
      progress: () => emit(const RankingLoading()),
      failure: (_) => emit(const RankingFailure()),
      success: (rankingFreezed) {
        if (rankingFreezed) {
          emit(const RankingFreezed());
        } else {
          loadItems();
        }
      },
    );
  }

  Future<void> loadItems() async {
    _getRankingUseCase().when(
      progress: () => emit(const RankingLoading()),
      success: (items) {
        final user = _getSignedUserUseCase();
        final userInList = items.any((element) => element.uid == user?.uid);
        if (!userInList) {
          loadYourItem();
        }
        emit(RankingLoaded(items: items, userUid: user!.uid));
      },
      failure: (_) => emit(const RankingFailure()),
    );
  }

  Future<void> loadYourItem() async {
    _getYourRankingUseCase().when(
      progress: () => emit(const YourRankingLoading()),
      success: (item) {
        if (item != null) {
          _getYourRankingPositionUseCase().listen((position) {
            if(position == null) {
              return;
            }
            emit(YourRankingLoaded(item: item, position: position));
          });
        } else {
          emit(const YourRankingNotInRanking());
        }
      },
      failure: (_) => emit(const YourRankingFailure()),
    );
  }
}
