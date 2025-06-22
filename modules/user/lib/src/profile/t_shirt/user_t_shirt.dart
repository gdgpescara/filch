import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../models/t_shirt_pick_up_state.dart';
import 'state/user_t_shirt_cubit.dart';
import 't_shirt_widget.dart';

class UserTShirt extends StatelessWidget {
  const UserTShirt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserTShirtCubit>(
      create: (context) => GetIt.I()..checkTShirt(),
      child: BlocBuilder<UserTShirtCubit, UserTShirtState>(
        builder:
            (context, state) => switch (state) {
              UserTShirtLoading() => const Center(child: LoaderAnimation()),
              UserTShirtFailure() => TShirtWidget(t.common.errors.generic, borderColor: appColors.error.seed),
              UserTShirtLoaded(status: TShirtPickUpState.pickedUp) => TShirtWidget(
                t.user.profile.user_info.t_shirt.picked,
                borderColor: appColors.success.seed,
              ),
              UserTShirtLoaded(status: TShirtPickUpState.requested) => TShirtWidget(
                t.user.profile.user_info.t_shirt.not_picked,
                borderColor: appColors.warning.seed,
              ),
              UserTShirtLoaded(status: TShirtPickUpState.none) => const SizedBox.shrink(),
            },
      ),
    );
  }
}
