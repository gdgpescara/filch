import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../_shared/error_handling/future_extension.dart';
import '../../../../models/active_quest.dart';
import '../../../../models/quest.dart';
import '../../../use_cases/submit_answer_use_case.dart';
import '../../../use_cases/validate_quiz_qr_code_use_case.dart';

part 'quiz_state.dart';

@injectable
class QuizCubit extends Cubit<QuizState> {
  QuizCubit(
    this._validateQuizQrCodeUseCase,
    this._submitAnswerUseCase,
  ) : super(const QuizNeedActivation());

  final ValidateQuizQrCodeUseCase _validateQuizQrCodeUseCase;
  final SubmitAnswerUseCase _submitAnswerUseCase;

  void activateQuiz(Quest quest, String scanResult) {
    _validateQuizQrCodeUseCase(quest, scanResult).actions(
      progress: () => emit(const QuizLoading()),
      success: (result) {
        if(result) {
          emit(const QuizActive());
        } else {
          emit(const QuizActivationFailure());
          emit(const QuizNeedActivation());
        }
      },
      failure: (_) {
        emit(const QuizActivationFailure());
        emit(const QuizNeedActivation());
      },
    );
  }

  void submitAnswer(ActiveQuest activeQuest, List<int> answersIds) {
    final current = state;
    _submitAnswerUseCase(activeQuest.quest, answersIds).actions(
      progress: () {
        emit(const QuizAnswerLoading());
        emit(current);
      },
      success: (result) {
        emit(QuizAnswerSent(isCorrect: result.$1, points: result.$2, house: result.$3));
        emit(current);
      },
      failure: (_) {
        emit(const QuizAnswerFailure());
        emit(current);
      },
    );
  }
}
