part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.user,
    this.isNimbusUser = false,
    this.staff = false,
    this.sponsor = false,
    this.team,
  });

  final User? user;
  final bool isNimbusUser;
  final bool staff;
  final bool sponsor;
  final Team? team;

  UserProfileState copyWith({
    User? user,
    bool? isNimbusUser,
    bool? staff,
    bool? sponsor,
    Team? team,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      isNimbusUser: isNimbusUser ?? this.isNimbusUser,
      staff: staff ?? this.staff,
      sponsor: sponsor ?? this.sponsor,
      team: team ?? this.team,
    );
  }

  @override
  List<Object?> get props => [user, isNimbusUser, staff, sponsor, team];

  bool get showPointsCard => !staff && !sponsor;
}

class SignedOut extends UserProfileState {
  const SignedOut() : super(user: null);
}
