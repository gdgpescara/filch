part of 'shifts_cubit.dart';

sealed class ShiftsState extends Equatable {
  const ShiftsState();
}

class ShiftsLoading extends ShiftsState {
  const ShiftsLoading();

  @override
  List<Object?> get props => [];
}

class ShiftsLoaded extends ShiftsState {
  const ShiftsLoaded(this.shifts);

  final List<Shift> shifts;

  @override
  List<Object?> get props => [shifts];
}

class ShiftsFailure extends ShiftsState {
  const ShiftsFailure();

  @override
  List<Object?> get props => [];
}
