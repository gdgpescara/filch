part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.user, this.house, this.isNimbusUser = false});

  final User? user;
  final String? house;
  final bool isNimbusUser;

  UserProfileState copyWith({User? user, String? house, bool? isNimbusUser}) {
    return UserProfileState(
      user: user ?? this.user,
      house: house ?? this.house,
      isNimbusUser: isNimbusUser ?? this.isNimbusUser,
    );
  }

  @override
  List<Object?> get props => [user, house, isNimbusUser];
}

class SignedOut extends UserProfileState {
  const SignedOut() : super(user: null, house: null);
}
