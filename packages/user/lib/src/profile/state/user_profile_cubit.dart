import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends SafeEmitterCubit<UserProfileState> {
  UserProfileCubit(
    GetSignedUserUseCase getSignedUserUseCase,
    this._signOutUseCase,
    this._staffUserUseCase,
    this._sponsorUserUseCase,
    this._getSignedUserTeamUseCase,
  ) : super(UserProfileState(user: getSignedUserUseCase()));

  final IsStaffUserUseCase _staffUserUseCase;
  final IsSponsorUserUseCase _sponsorUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetSignedUserTeamUseCase _getSignedUserTeamUseCase;

  Future<void> init() async {
    final (team, staff, sponsor) = await (
      _getSignedUserTeamUseCase(),
      _staffUserUseCase(),
      _sponsorUserUseCase(),
    ).wait;

    emit(state.copyWith(team: team, staff: staff, sponsor: sponsor));
  }

  void signOut() {
    _signOutUseCase();
    emit(const SignedOut());
  }
}
