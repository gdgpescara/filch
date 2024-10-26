import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui/ui.dart';

import '../current_quest/state/current_quest_cubit.dart';
import '../models/answer.dart';
import 'question_widget.dart';
import 'quiz_submit_button.dart';

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget({super.key});

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  final _form = FormGroup({});

  @override
  void initState() {
    super.initState();
    final state = context.read<CurrentQuestCubit>().state;
    if (state is CurrentQuestLoaded) {
      for (final answer in state.activeQuest.quest.answers ?? <Answer>[]) {
        _form.addAll({'${answer.id}': FormControl<bool>()});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
        buildWhen: (previous, current) => current is CurrentQuestLoaded,
        builder: (context, state) {
          state as CurrentQuestLoaded;
          final answers = state.activeQuest.quest.answers ?? [];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestionWidget(activeQuest: state.activeQuest),
              AppCard(
                style: AppCardStyle.caption,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.quests.active_quest.quiz.answer_option.label,
                      style: context
                          .getTextTheme(TextThemeType.monospace)
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: Spacing.s),
                    for (final answer in answers)
                      ReactiveCheckboxListTile(
                        formControlName: '${answer.id}',
                        title: Text(answer.text[LocaleSettings.currentLocale.languageCode] ?? ''),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              QuizSubmitButton(
                getSelectedAnswers: (form) {
                  final answers = <int>[];
                  for (final key in form.controls.keys) {
                    final control = form.control(key);
                    if (control.value == true) {
                      answers.add(int.parse(key));
                    }
                  }
                  return answers.isNotEmpty ? answers : null;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
