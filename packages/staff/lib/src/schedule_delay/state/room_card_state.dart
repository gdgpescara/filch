part of 'room_card_cubit.dart';

sealed class RoomCardState extends Equatable {
  const RoomCardState();

  @override
  List<Object?> get props => [];
}

final class RoomCardInitial extends RoomCardState {
  const RoomCardInitial();
}

final class RoomCardLoaded extends RoomCardState {
  const RoomCardLoaded(this.delay, this.originalDelay);

  final int delay;
  final int originalDelay;

  @override
  List<Object?> get props => [delay, originalDelay];
}
