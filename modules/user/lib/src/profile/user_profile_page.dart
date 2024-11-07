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
    required this.navigateToLogin,
    required this.navigateToAllPoints,
    this.embedded = false,
  });

  final VoidCallback navigateToSplash;
  final VoidCallback navigateToLogin;
  final VoidCallback navigateToAllPoints;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileCubit>(
      create: (context) => GetIt.I(),
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
            appBar: AppBar(
              backgroundColor: _bgColor,
              shadowColor: _bgColor,
              forceMaterialTransparency: embedded,
              elevation: _elevation,
              actions: [
                TextButton(
                  onPressed: context.read<UserProfileCubit>().signOut,
                  child: Text(t.common.buttons.sign_out.toUpperCase()),
                ),
              ],
            ),
            body: ListView(
              padding: _padding,
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    UserPicture(imageUrl: state.user?.photoURL),
                    Expanded(child: UserInfo(state.user)),
                  ],
                ),
                const SizedBox(height: Spacing.m),
                const UserTShirt(),
                const SizedBox(height: Spacing.xxl),
                UserQrCode(user: state.user),
                const SizedBox(height: Spacing.xxl),
                UserPointsCard(navigateToAllPoints: navigateToAllPoints),
                const SizedBox(height: Spacing.xxl),
                RemoveAccountButton(
                  onNeedLogin: navigateToLogin,
                  onAccountRemoved: navigateToSplash,
                ),
                const AppVersion(),
              ],
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

  double? get _elevation => embedded ? 0 : null;

  EdgeInsets get _padding {
    const padding = EdgeInsets.all(Spacing.m);
    // if (embedded) {
    //   return padding.copyWith(bottom: Spacing.m + kBottomNavigationBarHeight);
    // }
    return padding;
  }
}
