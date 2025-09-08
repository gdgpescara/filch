import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
      child: const _SessionDetailView(),
    );
  }
}

class _SessionDetailView extends StatelessWidget {
  const _SessionDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio della Sessione'),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SessionDetailCubit, SessionDetailState>(
          builder: (context, state) {
            return switch (state) {
              SessionDetailInitial() => const SizedBox.shrink(),
              SessionDetailLoading() => const Center(child: CircularProgressIndicator()),
              SessionDetailError(:final error) => Center(child: Text(error)),
              SessionDetailLoaded(:final session) => SessionDetailContent(session: session),
            };
          },
        ),
      ),
    );
  }
}
