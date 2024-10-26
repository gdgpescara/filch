import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';

import '../current_quest/state/current_quest_cubit.dart';

class GiveUpButton extends StatelessWidget {
  const GiveUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final shouldGiveUp = await showAdaptiveDialog<bool>(
            context: context,
            builder: (context) => const _GiveUpDialog(),
          );
          if ((shouldGiveUp ?? false) && context.mounted) {
            context.read<CurrentQuestCubit>().giveUp();
          }
        },
        child: Text(t.quests.active_quest.give_up.button),
      ),
    );
  }
}

class _GiveUpDialog extends StatelessWidget {
  const _GiveUpDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.quests.active_quest.give_up.title),
      content: Text(t.quests.active_quest.give_up.content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.common.buttons.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.common.buttons.confirm),
        ),
      ],
    );
  }
}
