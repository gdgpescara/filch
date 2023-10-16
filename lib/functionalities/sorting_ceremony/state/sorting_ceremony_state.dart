part of 'sorting_ceremony_cubit.dart';

sealed class SortingCeremonyState extends Equatable {
  const SortingCeremonyState();
}

class SortingCeremonyLoading extends SortingCeremonyState {
  @override
  List<Object> get props => [];
}

class SortingCeremonySuccess extends SortingCeremonyState {
  const SortingCeremonySuccess({required this.house});

  final String house;

  @override
  List<Object?> get props => [house];
}

class SortingCeremonyFailure extends SortingCeremonyState {
  const SortingCeremonyFailure({required this.failure});

  final String failure;

  @override
  List<Object?> get props => [failure];
}

abstract class SortingCeremonyEvent extends SortingCeremonyState {
  const SortingCeremonyEvent();
}

class SortingCeremonyFinish extends SortingCeremonyEvent {
  @override
  List<Object?> get props => [];
}