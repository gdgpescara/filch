import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/state/safe_emitter_cubit.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_house_use_case.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../common_functionalities/user/use_cases/is_signed_user_nimbus_user_use_case.dart';
import '../../../common_functionalities/user/use_cases/sign_out_use_case.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends SafeEmitterCubit<UserProfileState> {
  UserProfileCubit(
    GetSignedUserUseCase getSignedUserUseCase,
    this._signOutUseCase,
    this._getLoggedUserHouseUseCase,
    this._isSignedUserNimbusUserUseCase,
  ) : super(UserProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;
  final GetSignedUserHouseUseCase _getLoggedUserHouseUseCase;
  final IsSignedUserNimbusUserUseCase _isSignedUserNimbusUserUseCase;

  Future<void> init() async {
    final result = await Future.wait([
      _getLoggedUserHouseUseCase(),
      _isSignedUserNimbusUserUseCase(),
    ]);
    emit(state.copyWith(house: result[0] as String, isNimbusUser: result[1] as bool));
  }

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}
