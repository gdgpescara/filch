part of 'management_cubit.dart';

sealed class ManagementState extends Equatable {
  const ManagementState();

  @override
  List<Object?> get props => [];
}

class ManagementLoading extends ManagementState {
  const ManagementLoading();
}

class ManagementFailure extends ManagementState {
  const ManagementFailure();
}

class ManagementLoaded extends ManagementState {
  const ManagementLoaded({this.points = const [], this.quests = const [], this.maxRoomDelay = 0});

  final List<AssignablePoints> points;
  final List<Quest> quests;
  final int maxRoomDelay;

  ManagementLoaded copyWith({
    List<AssignablePoints>? points,
    List<Quest>? quests,
    int? maxRoomDelay,
  }) {
    return ManagementLoaded(
      points: points ?? this.points,
      quests: quests ?? this.quests,
      maxRoomDelay: maxRoomDelay ?? this.maxRoomDelay,
    );
  }

  @override
  List<Object?> get props => [points, quests, maxRoomDelay];
}
