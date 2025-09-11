import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/favorite_cubit.dart';
import '../state/favorite_state.dart';
import 'state/session_detail_cubit.dart';
import 'state/session_detail_state.dart';
import 'widgets/session_detail_content.dart';

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({
    super.key,
    required this.sessionId,
  });

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionDetailCubit>(
          create: (context) => GetIt.I()..init(sessionId),
        ),
        BlocProvider<FavoriteCubit>(
          create: (context) => GetIt.I()..init(sessionId),
        ),
      ],
      child: _SessionDetailView(sessionId: sessionId),
    );
  }
}

class _SessionDetailView extends StatelessWidget {
  const _SessionDetailView({required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionDetailCubit, SessionDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dettaglio della Sessione'),
            actions: _buildActions(context, state),
          ),
          body: SafeArea(
            top: false,
            child: switch (state) {
              SessionDetailInitial() => const SizedBox.shrink(),
              SessionDetailLoading() => const Center(child: CircularProgressIndicator()),
              SessionDetailError(:final error) => Center(child: Text(error)),
              SessionDetailLoaded(:final session) => SessionDetailContent(session: session),
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, SessionDetailState state) {
    if (state is! SessionDetailLoaded || state.session.isServiceSession) {
      return [];
    }

    return [
      BlocSelector<FavoriteCubit, FavoriteState, bool>(
        key: Key('favorite_button_${state.session.id}'),
        selector: (state) => state.isFavorite,
        builder: (context, isFavorite) {
          final color = appColors.googleYellow.brightnessColor(context).color;
          return IconButton(
            onPressed: () => context.read<FavoriteCubit>().toggle(sessionId),
            icon: Icon(isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star, color: color),
            tooltip: isFavorite ? t.schedule.sessions.session_card.remove_favorite : t.schedule.sessions.session_card.add_favorite,
          );
        },
      ),
    ];
  }
}
