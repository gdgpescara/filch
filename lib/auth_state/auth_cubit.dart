import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends SafeEmitterCubit<AuthState> {
  AuthCubit(this._authStateChangesUseCase) : super(const Unauthenticated());

  final AuthStateChangesUseCase _authStateChangesUseCase;

  void init() {
    _authStateChangesUseCase().when(
      success: (_) => emit(const Authenticated()),
      error: (_) => emit(const Unauthenticated()),
    );
  }
}
