part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.user, this.house});

  final User? user;
  final String? house;

  UserProfileState copyWith({
    User? user,
    String? house,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      house: house ?? this.house,
    );
  }

  @override
  List<Object?> get props => [user, house];
}

class SignedOut extends UserProfileState {
  const SignedOut() : super(user: null, house: null);
}
