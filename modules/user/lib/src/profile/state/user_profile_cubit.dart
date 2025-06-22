import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends SafeEmitterCubit<UserProfileState> {
  UserProfileCubit(GetSignedUserUseCase getSignedUserUseCase, this._signOutUseCase)
    : super(UserProfileState(user: getSignedUserUseCase()));

  final SignOutUseCase _signOutUseCase;

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}
