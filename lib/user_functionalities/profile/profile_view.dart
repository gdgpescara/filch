import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/splash/splash_page.dart';
import '../../common_functionalities/widgets/app_card.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../user_points/user_points_card.dart';
import 'state/profile_cubit.dart';
import 'widgets/email_widget.dart';
import 'widgets/user_picture.dart';
import 'widgets/user_qr_code.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => injector()..init(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => current is SignedOut,
        listener: (context, state) {
          if (state is SignedOut) {
            Navigator.pushNamedAndRemoveUntil(context, SplashPage.routeName, (route) => false);
          }
        },
        buildWhen: (previous, current) => current is! SignedOut,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              forceMaterialTransparency: true,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: context.read<ProfileCubit>().signOut,
                    child: Text(t.commons.buttons.sign_out.toUpperCase()),
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20).copyWith(bottom: 20 + kBottomNavigationBarHeight),
              shrinkWrap: true,
              children: [
                UserPicture(imageUrl: state.user?.photoURL, house: state.house),
                const SizedBox(height: 20),
                const EmailWidget(),
                const SizedBox(height: 20),
                const AppCard(child: UserQrCode()),
                const SizedBox(height: 20),
                const UserPointsCard(),
              ],
            ),
          );
        },
      ),
    );
  }
}
