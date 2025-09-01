import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'state/staff_profile_cubit.dart';

class StaffProfileView extends StatelessWidget {
  const StaffProfileView({super.key, required this.navigateToSplash});

  final VoidCallback navigateToSplash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffProfileCubit>(
      create: (context) => GetIt.I(),
      child: BlocConsumer<StaffProfileCubit, StaffProfileState>(
        listenWhen: (previous, current) => current is SignedOut,
        listener: (context, state) {
          if (state is SignedOut) navigateToSplash();
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
                TextButton(
                  onPressed: context.read<StaffProfileCubit>().signOut,
                  child: Text(t.common.buttons.sign_out.toUpperCase()),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20).copyWith(bottom: 20 + kBottomNavigationBarHeight),
              shrinkWrap: true,
              children: [
                UserPicture(imageUrl: state.user?.photoURL),
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
