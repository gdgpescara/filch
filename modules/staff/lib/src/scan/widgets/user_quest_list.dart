import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../../assignment/assignment_page.dart';
import '../state/scan_cubit.dart';

class UserQuestList extends StatelessWidget {
  const UserQuestList(this.navigateToAssignment, {super.key});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScanCubit, ScanState, List<Quest>>(
      selector: (state) => state is ScanLoaded ? state.quests : [],
      builder: (context, quests) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.staff.point_assignment.user_quests.label,
              style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: quests.map((item) => _ItemWidget(item, navigateToAssignment)).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(
    this.item,
    this.navigateToAssignment,
  );

  final Quest item;
  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToAssignment(AssignmentPageArgs.quest(points: item.points, quest: item.id)),
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.points.toString(),
              style: context.getTextTheme(TextThemeType.monospace).displaySmall,
            ),
            Text(item.description[LocaleSettings.currentLocale.languageCode] ?? ' - '),
          ],
        ),
      ),
    );
  }
}
