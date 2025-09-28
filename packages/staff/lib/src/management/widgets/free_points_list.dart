import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../../assignment/assignment_page.dart';
import '../state/management_cubit.dart';

class FreePointsList extends StatelessWidget {
  const FreePointsList(this.navigateToAssignment, {super.key});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManagementCubit, ManagementState, List<AssignablePoints>>(
      selector: (state) => state is ManagementLoaded ? state.points : [],
      builder: (context, points) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.staff.point_assignment.free_points.label,
              style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
              itemCount: points.length,
              itemBuilder: (context, index) => _ItemWidget(points[index], navigateToAssignment),
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
    final description = item.description[LocaleSettings.currentLocale.languageCode] ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(RadiusSize.m),
      onTap: () => navigateToAssignment(AssignmentPageArgs.points(item.points)),
      child: AppCard(
        style: AppCardStyle.bordered,
        padding: const EdgeInsets.all(Spacing.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                constraints: const BoxConstraints(minWidth: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(RadiusSize.m),
                ),
                child: Text(
                  item.points.toString(),
                  style: context
                      .getTextTheme(TextThemeType.monospace)
                      .titleMedium
                      ?.copyWith(color: context.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Gap.vertical(Spacing.s),
            Flexible(
              child: Text(
                description,
                style: context.textTheme.labelMedium?.copyWith(height: 1.2),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
