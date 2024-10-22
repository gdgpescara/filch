import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'state/user_t_shirt_cubit.dart';

class UserTShirt extends StatelessWidget {
  const UserTShirt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserTShirtCubit>(
      create: (context) => GetIt.I()..checkTShirt(),
      child: BlocBuilder<UserTShirtCubit, UserTShirtState>(
        builder: (context, state) => switch (state) {
          UserTShirtLoading() => const Center(child: LoaderAnimation()),
          UserTShirtFailure() => Text(t.common.errors.generic),
          UserTShirtLoaded(hasUserPickedTShirt: true) => Text(t.user.profile.user_info.t_shirt.picked),
          UserTShirtLoaded(hasUserPickedTShirt: false) => Text(t.user.profile.user_info.t_shirt.not_picked),
        },
      ),
    );
  }
}
