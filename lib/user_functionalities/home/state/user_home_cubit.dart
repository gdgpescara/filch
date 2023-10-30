import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  UserHomeCubit() : super(UserHomeInitial());
}
