import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../../common_functionalities/models/points.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_points_use_case.dart';

part 'user_points_state.dart';

@injectable
class UserPointsCubit extends Cubit<UserPointsState> {
  UserPointsCubit(this._getSignedUserPointsUseCase) : super(const UserPointsLoading());

  final GetSignedUserPointsUseCase _getSignedUserPointsUseCase;

  void loadPoints() {
    _getSignedUserPointsUseCase().actions(
      progress: () => emit(const UserPointsLoading()),
      success: (points) => emit(UserPointsLoaded(points)),
      failure: (_) => emit(const UserPointsFailure()),
    );
  }
}
