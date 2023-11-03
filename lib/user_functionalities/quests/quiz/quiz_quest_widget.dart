import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slang/builder/utils/string_extensions.dart';

import '../../../common_functionalities/widgets/loader_overlay.dart';
import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../../../theme/app_theme.dart';
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
      create: (_) => injector(),
      child: BlocSelector<CurrentQuestCubit, CurrentQuestState, CurrentQuestLoaded?>(
        selector: (state) => state is CurrentQuestLoaded ? state : null,
        builder: (context, currentQuestState) {
          if (currentQuestState == null) return const SizedBox();
          return BlocConsumer<QuizCubit, QuizState>(
            listenWhen: (previous, current) => current is QuizAnswerState || current is QuizActivationFailure,
            listener: (context, state) {
              switch (state) {
                case QuizAnswerLoading():
                  LoaderOverlay.show(
                    context,
                    message: t.active_quest.quiz.answer.evaluating,
                  );
                  break;
                case QuizAnswerSent():
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.isCorrect
                            ? t.active_quest.quiz.answer.correct(n: state.points, house: state.house.capitalize())
                            : t.active_quest.quiz.answer.incorrect(house: state.house.capitalize()),
                      ),
                      backgroundColor: state.isCorrect
                          ? Theme.of(context).extension<CustomColors>()?.success
                          : Theme.of(context).extension<CustomColors>()?.error,
                    ),
                  );
                  context.read<CurrentQuestCubit>().loadCurrentQuest();
                  break;
                case QuizAnswerFailure():
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.commons.errors.generic_retry),
                      backgroundColor: Theme.of(context).extension<CustomColors>()?.error,
                    ),
                  );
                  break;
                case QuizActivationFailure():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.active_quest.quiz.scan_error),
                      backgroundColor: Theme.of(context).extension<CustomColors>()?.error,
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
                QuizActive() => currentQuestState.activeQuest.quest.isMultipleChoice
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
