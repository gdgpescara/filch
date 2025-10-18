import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../models/session.dart';
import 'state/favorite_cubit.dart';
import 'state/favorite_state.dart';

class FavoriteToggleButton extends StatelessWidget {
  const FavoriteToggleButton({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      key: ValueKey('FavoriteToggleButton_${session.id}'),
      create: (context) => GetIt.I()..init(session),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final isFavorite = state.isFavorite;
          final color = appColors.googleYellow.brightnessColor(context).color;
          return switch (state) {
            FavoriteLoading() => const LoaderAnimation(),
            _ => IconButton(
              onPressed: () => context.read<FavoriteCubit>().toggle(session.id),
              icon: Icon(isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star, color: color),
              tooltip: isFavorite
                  ? t.schedule.sessions.session_card.remove_favorite
                  : t.schedule.sessions.session_card.add_favorite,
            ),
          };
        },
      ),
    );
  }
}
