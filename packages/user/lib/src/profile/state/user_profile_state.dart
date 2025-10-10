part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.user, this.house, this.isNimbusUser = false, this.isStaff = false, this.team});

  final User? user;
  final String? house;
  final bool isNimbusUser;
  final bool isStaff;
  final Team? team;

  UserProfileState copyWith({User? user, String? house, bool? isNimbusUser, bool? isStaff, Team? team}) {
    return UserProfileState(
      user: user ?? this.user,
      house: house ?? this.house,
      isNimbusUser: isNimbusUser ?? this.isNimbusUser,
      isStaff: isStaff ?? this.isStaff,
      team: team ?? this.team,
    );
  }

  @override
  List<Object?> get props => [user, house, isNimbusUser, isStaff, team];
}

class SignedOut extends UserProfileState {
  const SignedOut() : super(user: null, house: null);
}
