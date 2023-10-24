import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../../_shared/widgets/app_card.dart';
import '../../splash/splash_page.dart';
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
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: context.read<ProfileCubit>().signOut,
                      child: Text(t.commons.buttons.sign_out.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  UserPicture(imageUrl: state.user?.photoURL, house: state.house),
                  const SizedBox(height: 20),
                  const EmailWidget(),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: AppCard(child: UserQrCode()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
