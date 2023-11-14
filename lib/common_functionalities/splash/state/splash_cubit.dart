import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../state/safe_emitter_cubit.dart';
import '../../user/use_cases/has_house_use_case.dart';
import '../../user/use_cases/has_signed_user_use_case.dart';
import '../../user/use_cases/is_staff_user_use_case.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends SafeEmitterCubit<SplashState> {
  SplashCubit(
    this._hasSignedUserUseCase,
    this._hasHouseUseCase,
    this._isStaffUserUseCase,
  ) : super(SplashLoading());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final HasHouseUseCase _hasHouseUseCase;
  final IsStaffUserUseCase _isStaffUserUseCase;

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!_hasSignedUserUseCase()) {
      emit(const UserLoggedOut());
      return;
    }
    if (_isStaffUserUseCase()) {
      emit(const StaffUserLoggedIn());
      return;
    }
    if (!await _hasHouseUseCase()) {
      emit(const UserNeedSortingCeremony());
      return;
    }
    emit(const AppCanRun());
  }
}
