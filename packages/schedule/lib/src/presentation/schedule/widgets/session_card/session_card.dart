import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';
import '../../../state/favorite_cubit.dart';
import '../../../widgets/session_speakers.dart';
import '../../../widgets/session_tags.dart';
import 'session_time.dart';

class SessionCard extends StatelessWidget {
  const SessionCard(this.session, {super.key, required this.onTap});

  final Session session;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      key: Key('favorite_cubit_provider_${session.id}'),
      create: (context) => GetIt.I()..init(session.id),
      child: InkWell(
        onTap: () => !session.isServiceSession ? onTap(session.id) : null,
        child: AppCard(
          style: AppCardStyle.bordered,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SessionTime(session: session),

              const SizedBox(height: Spacing.m),
              Text(
                session.title,
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),

              if (session.description?.isNotEmpty ?? false) ...[
                const SizedBox(height: Spacing.s),
                Text(
                  session.description!.trim(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: Spacing.s),
              SessionTags(session: session),

              if (session.speakers.isNotEmpty) ...[
                const SizedBox(height: Spacing.s),
                SessionSpeakers(speakers: session.speakers),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
