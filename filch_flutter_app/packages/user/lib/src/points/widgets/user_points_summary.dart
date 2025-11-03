import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

import '../state/user_points_cubit.dart';

class UserPointsSummary extends StatelessWidget {
  const UserPointsSummary({super.key, required this.navigateToAllPoints});

  final VoidCallback navigateToAllPoints;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserPointsCubit, UserPointsState, int>(
      selector: (state) => state is UserPointsLoaded ? state.totals : 0,
      builder: (context, totalPoints) {
        return InkWell(
          onTap: navigateToAllPoints,
          borderRadius: BorderRadius.circular(RadiusSize.m),
          child: BlurContainer(
            clipRadius: BorderRadius.circular(RadiusSize.m),
            child: Container(
              padding: const EdgeInsets.all(Spacing.m),
              decoration: BoxDecoration(
                color: context.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(RadiusSize.m),
                border: Border.all(color: context.colorScheme.secondary),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(Spacing.m),
                    decoration: BoxDecoration(
                      color: context.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(RadiusSize.s),
                    ),
                    child: Icon(FontAwesomeIcons.medal, color: context.colorScheme.onSecondary, size: 24),
                  ),
                  const SizedBox(width: Spacing.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total Points', style: context.textTheme.bodyMedium),
                        Text(
                          '$totalPoints',
                          style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
