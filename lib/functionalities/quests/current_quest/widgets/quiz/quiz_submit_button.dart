import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../i18n/strings.g.dart';
import '../../state/current_quest_cubit.dart';
import 'state/quiz_cubit.dart';

class QuizSubmitButton extends StatelessWidget {
  const QuizSubmitButton({super.key, required this.getSelectedAnswers});

  final List<int>? Function(FormGroup form) getSelectedAnswers;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
      buildWhen: (previous, current) => current is CurrentQuestLoaded,
      builder: (context, currentQuestState) {
        currentQuestState as CurrentQuestLoaded;
        return ReactiveFormConsumer(
          builder: (context, form, child) {
            final value = getSelectedAnswers(form);
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: form.valid && value != null
                    ? () => context.read<QuizCubit>().submitAnswer(currentQuestState.activeQuest, value)
                    : null,
                child: Text(t.commons.buttons.confirm),
              ),
            );
          },
        );
      },
    );
  }
}