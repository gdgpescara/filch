import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/sessionize_sync_cubit.dart';

class SyncSessionize extends StatelessWidget {
  const SyncSessionize({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionizeSyncCubit>(
      create: (context) => GetIt.I(),
      child: AppCard(
        style: AppCardStyle.normal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.staff.sessionize_sync.title,
              style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              t.staff.sessionize_sync.description,
            ),
            const Gap.vertical(Spacing.m),
            BlocConsumer<SessionizeSyncCubit, SessionizeSyncState>(
              listener: (context, state) {
                switch (state) {
                  case SessionizeSyncSuccess():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.staff.sessionize_sync.success_message),
                      ),
                    );
                    break;
                  case SessionizeSyncFailure():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.staff.sessionize_sync.error_message(errorMessage: state.errorMessage)),
                      ),
                    );
                    break;
                  default:
                    break;
                }
              },
              builder: (context, state) {
                final isLoading = state is SessionizeSyncInProgress;
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : context.read<SessionizeSyncCubit>().syncSessionizeData,
                    child: isLoading ? const CircularProgressIndicator() : Text(t.staff.sessionize_sync.button_label),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
