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
  const ScanLoaded({
    this.points = const [],
    this.quests = const [],
  });

  final List<AssignablePoints> points;
  final List<Quest> quests;

  ScanLoaded copyWith({
    List<AssignablePoints>? points,
    List<Quest>? quests,
  }) {
    return ScanLoaded(
      points: points ?? this.points,
      quests: quests ?? this.quests,
    );
  }

  @override
  List<Object?> get props => [points, quests];
}
