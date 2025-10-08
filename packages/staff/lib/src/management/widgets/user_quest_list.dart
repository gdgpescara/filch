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
            Text(
              t.staff.point_assignment.user_quests.label,
              style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap.vertical(Spacing.m),
            Wrap(
              spacing: Spacing.l,
              runSpacing: Spacing.l,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: quests.map((quest) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quest.title?[LocaleSettings.currentLocale.languageCode] ?? ' - ',
                      style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap.vertical(Spacing.m),
                    Wrap(
                      spacing: Spacing.l,
                      runSpacing: Spacing.l,
                      children: [
                        ...quest.points.map((points) {
                          return _ItemWidget(quest.id, quest.type, points, navigateToAssignment);
                        }),
                      ],
                    ),
                  ],
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
      onTap: () => navigateToAssignment(
        AssignmentPageArgs.quest(points: points.toDouble(), questId: questId, questType: questType),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: AppCard(
          style: AppCardStyle.bordered,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(points.toString(), style: context.getTextTheme(TextThemeType.themeSpecific).displaySmall)],
          ),
        ),
      ),
    );
  }
}
