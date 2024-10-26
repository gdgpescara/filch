import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';
import 'package:user/src/profile/t_shirt/t_shirt_widget.dart';

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
          UserTShirtFailure() => TShirtWidget(t.common.errors.generic, borderColor: appColors.error.seed),
          UserTShirtLoaded(hasUserPickedTShirt: true) => TShirtWidget(t.user.profile.user_info.t_shirt.picked, borderColor: appColors.success.seed),
          UserTShirtLoaded(hasUserPickedTShirt: false) => TShirtWidget(t.user.profile.user_info.t_shirt.not_picked, borderColor: appColors.warning.seed),
        },
      ),
    );
  }
}
