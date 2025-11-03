import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../../assignment/assignment_page.dart';
import '../state/management_cubit.dart';

class UserQuestList extends StatelessWidget {
  const UserQuestList(this.navigateToAssignment, {super.key});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManagementCubit, ManagementState, List<Quest>>(
      selector: (state) => state is ManagementLoaded ? state.quests : [],
      builder: (context, quests) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: Spacing.l,
              runSpacing: Spacing.l,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: quests.map((quest) {
                return AppCard(
                  style: AppCardStyle.bordered,
                  padding: const EdgeInsets.all(Spacing.m),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(quest.id, style: context.getTextTheme(TextThemeType.monospace).bodyMedium),
                      Text(
                        quest.title?[LocaleSettings.currentLocale.languageCode] ?? ' - ',
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap.vertical(Spacing.m),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Spacing.s,
                          mainAxisSpacing: Spacing.s,
                        ),
                        itemCount: quest.points.length,
                        itemBuilder: (context, index) => _ItemWidget(quest.id, quest.type, quest.points[index], navigateToAssignment),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.questId, this.questType, this.points, this.navigateToAssignment);

  final String questId;
  final QuestTypeEnum questType;
  final int points;
  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(RadiusSize.m),
      onTap: () => navigateToAssignment(
        AssignmentPageArgs.quest(points: points.toDouble(), questId: questId, questType: questType),
      ),
      child: AppCard(
        style: AppCardStyle.bordered,
        padding: const EdgeInsets.all(Spacing.s),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
          constraints: const BoxConstraints(minWidth: 50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(RadiusSize.m),
          ),
          child: Text(
            points.toString(),
            style: context
                .getTextTheme(TextThemeType.monospace)
                .titleMedium
                ?.copyWith(color: context.colorScheme.onSecondaryContainer, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
