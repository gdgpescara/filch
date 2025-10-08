import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../current_quest/state/current_quest_cubit.dart';
import 'multiple_choice_widget.dart';
import 'quiz_scan_view.dart';
import 'single_choice_widget.dart';
import 'state/quiz_cubit.dart';

class QuizQuestWidget extends StatelessWidget {
  const QuizQuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (_) => GetIt.I(),
      child: BlocSelector<CurrentQuestCubit, CurrentQuestState, CurrentQuestLoaded?>(
        selector: (state) => state is CurrentQuestLoaded ? state : null,
        builder: (context, currentQuestState) {
          if (currentQuestState == null) return const SizedBox();
          return BlocConsumer<QuizCubit, QuizState>(
            listenWhen: (previous, current) {
              return current is QuizAnswerState || current is QuizActivationFailure;
            },
            listener: (context, state) {
              switch (state) {
                case QuizAnswerLoading():
                  LoaderOverlay.show(context, message: t.quests.active_quest.quiz.answer.evaluating);
                  break;
                case QuizAnswerSent(isCorrect: _, points: _):
                  LoaderOverlay.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.isCorrect
                            ? t.quests.active_quest.quiz.answer.correct(n: state.points)
                            : t.quests.active_quest.quiz.answer.incorrect,
                      ),
                      backgroundColor: state.isCorrect ? appColors.success.seed : appColors.error.seed,
                    ),
                  );
                  break;
                case QuizAnswerFailure():
                  LoaderOverlay.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.common.errors.generic_retry), backgroundColor: appColors.error.seed),
                  );
                  break;
                case QuizActivationFailure():
                  LoaderOverlay.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.quests.active_quest.quiz.scan_error),
                      backgroundColor: appColors.error.seed,
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            buildWhen: (previous, current) => current is! QuizAnswerState,
            builder: (context, state) {
              return switch (state) {
                QuizNeedActivation() => const QuizScanView(),
                QuizActive() =>
                  currentQuestState.activeQuest.quest.isMultipleChoice
                      ? const MultipleChoiceWidget()
                      : const SingleChoiceWidget(),
                _ => const SizedBox(),
              };
            },
          );
        },
      ),
    );
  }
}
