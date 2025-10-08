import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ui/ui.dart';

import '../current_quest/state/current_quest_cubit.dart';
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
            final isEnabled = form.valid && value != null;

            return ElevatedButton(
              onPressed: isEnabled ? () => context.read<QuizCubit>().submitAnswer(currentQuestState.activeQuest, value) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? context.colorScheme.primary : context.colorScheme.surface,
                foregroundColor: isEnabled ? context.colorScheme.onPrimary : context.colorScheme.onSurface.withValues(alpha: 0.5),
                elevation: isEnabled ? 2 : 0,
                shadowColor: isEnabled ? context.colorScheme.primary.withValues(alpha: 0.3) : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusSize.s),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.send_rounded,
                    size: 20,
                    color: isEnabled ? context.colorScheme.onPrimary : context.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: Spacing.s),
                  Text(
                    t.common.buttons.confirm,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isEnabled ? context.colorScheme.onPrimary : context.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
