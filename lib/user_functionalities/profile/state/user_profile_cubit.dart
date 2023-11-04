import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_house_use_case.dart';
import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../common_functionalities/user/use_cases/sign_out_use_case.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(
    GetSignedUserUseCase getSignedUserUseCase,
    this._signOutUseCase,
    this._getLoggedUserHouseUseCase,
  ) : super(UserProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;
  final GetSignedUserHouseUseCase _getLoggedUserHouseUseCase;

  Future<void> init() async {
    final house = await _getLoggedUserHouseUseCase();
    emit(state.copyWith(house: house));
  }

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}