import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';

import '../widgets/favorite_toggle_button.dart';
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
    return BlocProvider<SessionDetailCubit>(
      create: (context) => GetIt.I()..init(sessionId),
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
            title: Text(t.schedule.sessions.session_detail.title),
            actions: _buildActions(context, state),
          ),
          body: SafeArea(
            top: false,
            child: switch (state) {
              SessionDetailInitial() => const SizedBox.shrink(),
              SessionDetailLoading() => const Center(child: CircularProgressIndicator()),
              SessionDetailError(:final error) => Center(child: Text(error)),
              SessionDetailLoaded(:final session, :final delay) => SessionDetailContent(session: session, delay: delay),
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, SessionDetailState state) {
    final shouldShowFavoriteButton = state is SessionDetailLoaded && !state.session.isServiceSession;

    return [
      if (shouldShowFavoriteButton) FavoriteToggleButton(session: state.session),
    ];
  }
}
