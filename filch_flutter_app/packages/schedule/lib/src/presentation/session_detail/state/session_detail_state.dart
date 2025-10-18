import 'package:equatable/equatable.dart';
import '../../../models/models.dart';

sealed class SessionDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SessionDetailInitial extends SessionDetailState {}

class SessionDetailLoading extends SessionDetailState {}

class SessionDetailLoaded extends SessionDetailState {
  SessionDetailLoaded({required this.session, required this.delay});

  final Session session;
  final int delay;

  @override
  List<Object?> get props => [session, delay];
}

class SessionDetailError extends SessionDetailState {
  SessionDetailError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
