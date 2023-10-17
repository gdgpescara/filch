part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(this.user);

  final User?  user;

  @override
  List<Object?> get props => [user];
}