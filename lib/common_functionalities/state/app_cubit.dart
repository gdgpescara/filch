import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'safe_emitter_cubit.dart';

part 'app_state.dart';

@injectable
class AppCubit extends SafeEmitterCubit<AppState> {
  AppCubit(this._auth) : super(const AppUnauthenticated());

  final FirebaseAuth _auth;

  void init() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        emit(const AppUnauthenticated());
      } else {
        emit(const AppAuthenticated());
      }
    });
  }
}
