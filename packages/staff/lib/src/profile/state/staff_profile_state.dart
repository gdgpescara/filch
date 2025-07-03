part of 'staff_profile_cubit.dart';

class StaffProfileState extends Equatable {
  const StaffProfileState({this.user});

  final User? user;
  @override
  List<Object?> get props => [user];
}

class SignedOut extends StaffProfileState {
  const SignedOut() : super(user: null);
}
