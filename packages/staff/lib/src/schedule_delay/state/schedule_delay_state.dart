part of 'schedule_delay_cubit.dart';

sealed class ScheduleDelayState extends Equatable {
  const ScheduleDelayState();

  @override
  List<Object?> get props => [];
}

final class ScheduleDelayLoading extends ScheduleDelayState {
  const ScheduleDelayLoading();
}

final class ScheduleDelayLoaded extends ScheduleDelayState {
  const ScheduleDelayLoaded(this.rooms);

  final List<NamedEntity> rooms;

  @override
  List<Object?> get props => [rooms];
}

final class ScheduleDelayFailure extends ScheduleDelayState {
  const ScheduleDelayFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
