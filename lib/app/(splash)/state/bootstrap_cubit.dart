import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'bootstrap_state.dart';

@injectable
class BootstrapCubit extends Cubit<BootstrapState> {
  BootstrapCubit() : super(const BootstrapInitial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 10), () {});
    emit(const BootstrapDone());
  }
}
