import 'package:bloc/bloc.dart';

abstract class SafeEmitterCubit<State> extends BlocBase<State> {
  SafeEmitterCubit(super.initialState);

  @override
  void emit(State state) {
    if (state != super.state && !super.isClosed) {
      super.emit(state);
    }
  }
}
