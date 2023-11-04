import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/splash/splash_page.dart';
import '../../common_functionalities/widgets/user_info.dart';
import '../../common_functionalities/widgets/user_picture.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/staff_profile_cubit.dart';

class StaffProfileView extends StatelessWidget {
  const StaffProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffProfileCubit>(
      create: (context) => injector(),
      child: BlocConsumer<StaffProfileCubit, StaffProfileState>(
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
                    onPressed: context.read<StaffProfileCubit>().signOut,
                    child: Text(t.commons.buttons.sign_out.toUpperCase()),
                  ),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20).copyWith(bottom: 20 + kBottomNavigationBarHeight),
              shrinkWrap: true,
              children: [
                const UserPicture(),
                const SizedBox(height: 20),
                UserInfo(state.user),
              ],
            ),
          );
        },
      ),
    );
  }
}
