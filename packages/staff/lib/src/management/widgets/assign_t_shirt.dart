import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/management_cubit.dart';

class AssignTShirt extends StatelessWidget {
  const AssignTShirt(this.navigateToTShirtAssignment, {super.key});

  final VoidCallback navigateToTShirtAssignment;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.normal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${t.staff.t_shirt_assignment.label}:',
            style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          BlocBuilder<ManagementCubit, ManagementState>(
            builder: (context, state) {
              return switch (state) {
                ManagementLoading() => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Spacing.m),
                    child: CircularProgressIndicator(),
                  ),
                ),
                ManagementFailure() => const SizedBox.shrink(),
                ManagementLoaded() => _buildMessage(context, state.countUsersWithTShirt, state.countUsersWithoutTShirt),
              };
            },
          ),
          const Gap.vertical(Spacing.m),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(onPressed: navigateToTShirtAssignment, child: Text(t.staff.t_shirt_assignment.label)),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, int assigned, int totals) {
    return Text.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: t.staff.t_shirt_assignment.message_part_1),
          TextSpan(
            text: assigned.toString(),
            style: context.getTextTheme(TextThemeType.monospace).bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: t.staff.t_shirt_assignment.message_part_2),
          TextSpan(
            text: totals.toString(),
            style: context.getTextTheme(TextThemeType.monospace).bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: t.staff.t_shirt_assignment.message_part_3),
        ],
      ),
    );
  }
}
