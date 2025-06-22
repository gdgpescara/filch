import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui/ui.dart';

import '../current_quest/state/current_quest_cubit.dart';
import 'question_widget.dart';
import 'quiz_submit_button.dart';

class SingleChoiceWidget extends StatefulWidget {
  const SingleChoiceWidget({super.key});

  @override
  State<SingleChoiceWidget> createState() => _SingleChoiceWidgetState();
}

class _SingleChoiceWidgetState extends State<SingleChoiceWidget> {
  final _form = FormGroup({
    'answer': FormControl<int>(validators: [Validators.required]),
  });

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
                    const SizedBox(height: 10),
                    for (final answer in answers)
                      ReactiveRadioListTile<int>(
                        formControlName: 'answer',
                        title: Text(answer.text[LocaleSettings.currentLocale.languageCode] ?? ''),
                        enableFeedback: true,
                        contentPadding: EdgeInsets.zero,
                        value: answer.id,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              QuizSubmitButton(
                getSelectedAnswers: (form) {
                  final answer = form.control('answer').value as int?;
                  return answer != null ? [answer] : null;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
