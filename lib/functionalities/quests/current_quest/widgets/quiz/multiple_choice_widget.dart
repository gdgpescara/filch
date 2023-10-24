import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../_shared/widgets/app_card.dart';
import '../../../models/answer.dart';
import '../../state/current_quest_cubit.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.active_quest.quiz.answer_option.label,
                  style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
                  buildWhen: (previous, current) => current is CurrentQuestLoaded,
                  builder: (context, state) {
                    if(state is CurrentQuestLoaded) {
                      final answers = state.activeQuest.quest.answers ?? [];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final answer in answers)
                            ReactiveCheckboxListTile(
                              formControlName: '${answer.id}',
                              title: Text(answer.text),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
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
      ),
    );
  }
}
