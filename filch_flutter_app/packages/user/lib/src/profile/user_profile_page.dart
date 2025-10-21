import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../points/user_points_card.dart';
import 'state/user_profile_cubit.dart';
import 't_shirt/user_t_shirt.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.navigateToSplash,
    required this.navigateToAllPoints,
    this.embedded = false,
  });

  final VoidCallback navigateToSplash;
  final VoidCallback navigateToAllPoints;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listenWhen: (previous, current) => current is SignedOut,
        listener: (context, state) {
          if (state is SignedOut) {
            navigateToSplash();
          }
        },
        buildWhen: (previous, current) => current is! SignedOut,
        builder: (context, state) {
          final body = Scaffold(
            backgroundColor: _bgColor,
            body: SafeArea(
              bottom: false,
              child: ListView(
                padding: _padding,
                shrinkWrap: true,
                children: [
                  UserProfileHeader(
                    user: state.user,
                    team: state.team,
                    staffUser: state.staff,
                    sponsorUser: state.sponsor,
                  ),
                  const SizedBox(height: Spacing.m),
                  const UserTShirt(),
                  const SizedBox(height: Spacing.m),
                  if (state.showPointsCard) ...[
                    UserPointsCard(navigateToAllPoints: navigateToAllPoints),
                    const SizedBox(height: Spacing.l),
                  ],
                  const SizedBox(height: Spacing.l),
                  ElevatedButton(
                    onPressed: context.read<UserProfileCubit>().signOut,
                    child: Text(t.common.buttons.sign_out.toUpperCase()),
                  ),
                  const SizedBox(height: Spacing.l),
                  RemoveAccountButton(onAccountRemoved: navigateToSplash),
                  const SizedBox(height: Spacing.l),
                  const AppVersion(),
                ],
              ),
            ),
          );

          if (embedded) {
            return body;
          }
          return Background(child: body);
        },
      ),
    );
  }

  Color? get _bgColor => embedded ? Colors.transparent : null;

  EdgeInsets get _padding {
    return const EdgeInsets.all(Spacing.m);
  }
}
