import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../../assignment/assignment_page.dart';
import '../state/scan_cubit.dart';

class FreePointsList extends StatelessWidget {
  const FreePointsList(this.navigateToAssignment, {super.key});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScanCubit, ScanState, List<AssignablePoints>>(
      selector: (state) => state is ScanLoaded ? state.points : [],
      builder: (context, points) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.staff.point_assignment.free_points.label,
              style: context.getTextTheme(TextThemeType.monospace).titleMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: points.map((item) => _ItemWidget(item, navigateToAssignment)).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.item, this.navigateToAssignment);

  final AssignablePoints item;
  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToAssignment(AssignmentPageArgs.points(item.points)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.points.toString(),
                style:
                    context.getTextTheme(TextThemeType.monospace).displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(item.description[LocaleSettings.currentLocale.languageCode] ?? ' - '),
            ],
          ),
        ),
      ),
    );
  }
}
