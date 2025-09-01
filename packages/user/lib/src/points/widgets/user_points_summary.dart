import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/user_points_cubit.dart';

class UserPointsSummary extends StatelessWidget {
  const UserPointsSummary({super.key, required this.navigateToAllPoints});

  final VoidCallback navigateToAllPoints;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserPointsCubit, UserPointsState, UserPointsLoaded>(
      selector: (state) => state is UserPointsLoaded ? state : const UserPointsLoaded([]),
      builder: (context, loadedState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text('${loadedState.totals}', style: context.getTextTheme(TextThemeType.themeSpecific).titleLarge),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: navigateToAllPoints, child: Text(t.user.profile.my_points.detail_button.label)),
          ],
        );
      },
    );
  }
}
