import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'staff_profile_state.dart';

@injectable
class StaffProfileCubit extends SafeEmitterCubit<StaffProfileState> {
  StaffProfileCubit(GetSignedUserUseCase getSignedUserUseCase, this._signOutUseCase)
    : super(StaffProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}
