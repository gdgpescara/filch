import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'user_points_state.dart';

@injectable
class UserPointsCubit extends SafeEmitterCubit<UserPointsState> {
  UserPointsCubit(this._getSignedUserPointsUseCase) : super(const UserPointsLoading());

  final GetSignedUserPointsUseCase _getSignedUserPointsUseCase;

  void loadPoints() {
    _getSignedUserPointsUseCase().when(
      progress: () => emit(const UserPointsLoading()),
      success: (points) => emit(UserPointsLoaded(points)),
      failure: (_) => emit(const UserPointsFailure()),
    );
  }
}
