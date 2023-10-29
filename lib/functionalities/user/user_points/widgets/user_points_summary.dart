import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../i18n/strings.g.dart';
import '../state/user_points_cubit.dart';
import '../user_points_page.dart';

class UserPointsSummary extends StatelessWidget {
  const UserPointsSummary({super.key});

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
              child: Text('${loadedState.totals}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, UserPointsPage.routeName),
              child: Text(t.profile.my_points.detail_button.label),
            ),
          ],
        );
      },
    );
  }
}
