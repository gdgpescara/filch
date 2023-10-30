part of 'quiz_cubit.dart';

sealed class QuizState extends Equatable {
  const QuizState();
}

class QuizNeedActivation extends QuizState {
  const QuizNeedActivation();

  @override
  List<Object> get props => [];
}

class QuizLoading extends QuizState {
  const QuizLoading();

  @override
  List<Object> get props => [];
}

class QuizActive extends QuizState {
  const QuizActive();

  @override
  List<Object> get props => [];
}

class QuizActivationFailure extends QuizState {
  const QuizActivationFailure();

  @override
  List<Object> get props => [];
}

sealed class QuizAnswerState extends QuizState {
  const QuizAnswerState();
}

class QuizAnswerLoading extends QuizAnswerState {
  const QuizAnswerLoading();

  @override
  List<Object> get props => [];
}

class QuizAnswerSent extends QuizAnswerState {
  const QuizAnswerSent({
    required this.isCorrect,
    required this.points,
    required this.house,
  });

  final bool isCorrect;

  final int points;

  final String house;

  @override
  List<Object> get props => [isCorrect, points];
}

class QuizAnswerFailure extends QuizAnswerState {
  const QuizAnswerFailure();

  @override
  List<Object> get props => [];
}
