import 'dart:async';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../use_cases/is_favorite_use_case.dart';
import '../../../use_cases/toggle_favorite_use_case.dart';
import 'favorite_state.dart';

@injectable
class FavoriteCubit extends SafeEmitterCubit<FavoriteState> {
  FavoriteCubit(
    this._toggleFavoriteUseCase,
    this._isFavoriteUseCase,
  ) : super(const FavoriteState());

  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final IsFavoriteUseCase _isFavoriteUseCase;

  StreamSubscription<bool>? _favoriteSubscription;

  void init(String sessionId) {
    _favoriteSubscription?.cancel();
    _favoriteSubscription = _isFavoriteUseCase(sessionId).when(
      progress: () => emit(FavoriteLoading(isFavorite: state.isFavorite)),
      success: (isFavorite) => emit(FavoriteState(isFavorite: isFavorite)),
      error: (error) => emit(const FavoriteState()),
    );
  }

  void toggle(String sessionId) {
    _toggleFavoriteUseCase(sessionId).when(
      progress: () => emit(FavoriteToggleLoading(isFavorite: state.isFavorite)),
      success: (isFavorite) => emit(FavoriteToggleSuccess(isFavorite: isFavorite)),
      error: (error) => emit(FavoriteToggleError(isFavorite: state.isFavorite)),
    );
  }

  @override
  Future<void> close() {
    _favoriteSubscription?.cancel();
    return super.close();
  }
}
