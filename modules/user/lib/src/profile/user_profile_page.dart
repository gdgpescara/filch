import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';
import 'package:user/src/profile/state/user_profile_cubit.dart';
import 'package:user/src/profile/user_info.dart';
import 'package:user/src/profile/user_picture.dart';
import 'package:user/src/profile/user_qr_code.dart';

import '../points/user_points_card.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
    required this.navigateToSplash,
    required this.navigateToLogin,
    required this.navigateToAllPoints,
    this.backGroundBuilder,
    this.embedded = false,
  }) : assert(embedded || backGroundBuilder != null);

  final VoidCallback navigateToSplash;
  final VoidCallback navigateToLogin;
  final VoidCallback navigateToAllPoints;
  final Widget Function({required Widget child})? backGroundBuilder;
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
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextButton(
                    onPressed: context.read<UserProfileCubit>().signOut,
                    child: Text(t.common.buttons.sign_out.toUpperCase()),
                  ),
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
                const SizedBox(height: Spacing.xxl),
                SizedBox(
                  height: 230,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset('images/lines.svg', package: 'assets'),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: UserQrCode(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.xxl),
                UserPointsCard(navigateToAllPoints: navigateToAllPoints),
                const SizedBox(height: Spacing.xxl),
                RemoveAccountButton(
                  onNeedLogin: navigateToLogin,
                  onAccountRemoved: navigateToSplash,
                ),
              ],
            ),
          );

          if (embedded) {
            return body;
          }
          return backGroundBuilder!(child: body);
        },
      ),
    );
  }

  Color? get _bgColor => embedded ? Colors.transparent : null;

  double? get _elevation => embedded ? 0 : null;

  EdgeInsets get _padding {
    const padding = EdgeInsets.all(Spacing.m);
    if (embedded) {
      return padding.copyWith(bottom: Spacing.m + kBottomNavigationBarHeight);
    }
    return padding;
  }
}
