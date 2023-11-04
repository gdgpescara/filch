import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../common_functionalities/user/use_cases/sign_out_use_case.dart';

part 'staff_profile_state.dart';

@injectable
class StaffProfileCubit extends Cubit<StaffProfileState> {
  StaffProfileCubit(
    GetSignedUserUseCase getSignedUserUseCase,
    this._signOutUseCase,
  ) : super(StaffProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}
