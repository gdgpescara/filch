import 'package:filch/user_functionalities/user_points/widgets/user_points_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import '../../../common_functionalities/widgets/loader_animation.dart';
import 'state/user_points_cubit.dart';

class UserPointsCard extends StatelessWidget {
  const UserPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocProvider<UserPointsCubit>(
        create: (context) => injector()..loadPoints(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.profile.my_points.label,
              style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<UserPointsCubit, UserPointsState>(
              builder: (context, state) {
                return switch (state) {
                  UserPointsLoading() => const Center(child: LoaderAnimation()),
                  UserPointsLoaded() => const UserPointsSummary(),
                  UserPointsFailure() => Center(child: Text(t.commons.errors.generic_retry)),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
