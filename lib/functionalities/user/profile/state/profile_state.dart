part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.user, this.house});

  final User?  user;
  final String? house;

  ProfileState copyWith({
    User? user,
    String? house,
  }) {
    return ProfileState(
      user: user ?? this.user,
      house: house ?? this.house,
    );
  }

  @override
  List<Object?> get props => [user, house];
}