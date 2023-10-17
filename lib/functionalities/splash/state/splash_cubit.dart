import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../user/domain/use_cases/has_house_use_case.dart';
import '../../user/domain/use_cases/has_signed_user_use_case.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(
    this._hasSignedUserUseCase,
    this._hasHouseUseCase,
  ) : super(SplashLoading());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final HasHouseUseCase _hasHouseUseCase;

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!_hasSignedUserUseCase()) {
      emit(const UserLoggedOut());
      return;
    }
    if (!await _hasHouseUseCase()) {
      emit(const UserNeedSortingCeremony());
      return;
    }
    emit(const AppCanRun());
  }
}
