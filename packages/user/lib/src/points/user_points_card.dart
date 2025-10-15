import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'state/user_points_cubit.dart';
import 'widgets/user_points_summary.dart';

class UserPointsCard extends StatelessWidget {
  const UserPointsCard({super.key, required this.navigateToAllPoints});

  final VoidCallback navigateToAllPoints;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPointsCubit>(
      create: (context) => GetIt.I()..loadPoints(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.user.profile.my_points.label,
            style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Spacing.s),
          BlocBuilder<UserPointsCubit, UserPointsState>(
            builder: (context, state) {
              return switch (state) {
                UserPointsLoading() => const Center(child: LoaderAnimation()),
                UserPointsLoaded() => UserPointsSummary(navigateToAllPoints: navigateToAllPoints),
                UserPointsFailure() => Center(child: Text(t.common.errors.generic_retry)),
              };
            },
          ),
        ],
      ),
    );
  }
}
