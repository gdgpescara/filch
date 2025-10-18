import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../models/session.dart';
import '../../../use_cases/toggle_favorite_use_case.dart';
import 'favorite_state.dart';

@injectable
class FavoriteCubit extends SafeEmitterCubit<FavoriteState> {
  FavoriteCubit(this._toggleFavoriteUseCase) : super(const FavoriteState());

  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  void init(Session session) {
    emit(FavoriteState(isFavorite: session.isFavorite));
  }

  void toggle(String sessionId) {
    _toggleFavoriteUseCase(sessionId).when(
      progress: () => emit(FavoriteToggleLoading(isFavorite: !state.isFavorite)),
      success: (isFavorite) => emit(FavoriteToggleSuccess(isFavorite: isFavorite)),
      error: (error) => emit(FavoriteToggleError(isFavorite: !state.isFavorite)),
    );
  }
}
