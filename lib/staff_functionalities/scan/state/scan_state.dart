part of 'scan_cubit.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

class ScanFailure extends ScanState {
  const ScanFailure();
}

class ScanLoaded extends ScanState {
  const ScanLoaded(this.points);

  final List<AssignablePoints> points;

  @override
  List<Object?> get props => [points];
}
