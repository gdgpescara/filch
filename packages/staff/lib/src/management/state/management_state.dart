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
  const ManagementLoaded({
    this.points = const [],
    this.quests = const [],
    this.maxRoomDelay = 0,
    this.countUsersWithTShirt = 0,
    this.countUsersWithoutTShirt = 0,
  });

  final List<AssignablePoints> points;
  final List<Quest> quests;
  final int maxRoomDelay;
  final int countUsersWithTShirt;
  final int countUsersWithoutTShirt;

  ManagementLoaded copyWith({
    List<AssignablePoints>? points,
    List<Quest>? quests,
    int? maxRoomDelay,
    int? countUsersWithTShirt,
    int? countUsersWithoutTShirt,
  }) {
    return ManagementLoaded(
      points: points ?? this.points,
      quests: quests ?? this.quests,
      maxRoomDelay: maxRoomDelay ?? this.maxRoomDelay,
      countUsersWithTShirt: countUsersWithTShirt ?? this.countUsersWithTShirt,
      countUsersWithoutTShirt: countUsersWithoutTShirt ?? this.countUsersWithoutTShirt,
    );
  }

  @override
  List<Object?> get props => [points, quests, maxRoomDelay, countUsersWithTShirt, countUsersWithoutTShirt];
}
