import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../../_shared/widgets/loader_animation.dart';
import '../widgets/archived_quests_list.dart';
import '../widgets/archived_quests_retrive_error.dart';
import 'state/personal_archived_quests_cubit.dart';

class PersonalArchivedQuestsTab extends StatelessWidget {
  const PersonalArchivedQuestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalArchivedQuestsCubit>(
      create: (_) => injector()..loadArchivedQuests(),
      child: BlocBuilder<PersonalArchivedQuestsCubit, PersonalArchivedQuestsState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: switch (state) {
              PersonalArchivedQuestsLoading() => const Center(child: LoaderAnimation()),
              PersonalArchivedQuestsLoaded(archivedQuests: final archivedQuests) => ArchivedQuestsList(archivedQuests),
              PersonalArchivedQuestsFailure() => ArchivedQuestsRetrieveError(
                  onTryAgain: context.read<PersonalArchivedQuestsCubit>().loadArchivedQuests,
                )
            },
          );
        },
      ),
    );
  }
}
