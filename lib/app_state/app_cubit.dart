import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'app_state.dart';

@injectable
class AppCubit extends SafeEmitterCubit<AppState> {
  AppCubit(this._authStateChangesUseCase) : super(const AppUnauthenticated());

  final AuthStateChangesUseCase _authStateChangesUseCase;

  void init() {
    _authStateChangesUseCase().listen((user) {
      if (user == null) {
        emit(const AppUnauthenticated());
      } else {
        emit(const AppAuthenticated());
      }
    });
  }
}
