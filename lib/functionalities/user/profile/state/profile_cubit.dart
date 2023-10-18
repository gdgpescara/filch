import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_logger_user_house_use_case.dart';
import '../../domain/use_cases/get_signed_user.dart';
import '../../domain/use_cases/sign_out_use_case.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    GetSignedUserUseCase getSignedUserUseCase,
    this._signOutUseCase,
    this._getLoggedUserHouseUseCase,
  ) : super(ProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;
  final GetLoggedUserHouseUseCase _getLoggedUserHouseUseCase;

  Future<void> init() async {
    final house = await _getLoggedUserHouseUseCase();
    emit(state.copyWith(house: house));
  }

  void signOut() {
    _signOutUseCase();
    emit(const ProfileState());
  }
}
