import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:schedule/schedule.dart';
import 'package:ui/ui.dart';

import 'state/room_card_cubit.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key, required this.room});

  final NamedEntity room;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCardCubit, RoomCardState>(
      builder: (context, state) {
        final (delay, originalDelay) = switch (state) {
          RoomCardInitial() => (0, 0),
          RoomCardLoaded(delay: final d, originalDelay: final o) => (d, o),
        };
        final hasChanges = delay != originalDelay;

        return AppCard(
          style: AppCardStyle.normal,
          padding: const EdgeInsets.all(Spacing.m),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        room.name,
                        style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      '${t.staff.schedule_delay.id_label}${room.id}',
                      style: context.getTextTheme(TextThemeType.monospace).bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.m),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => context.read<RoomCardCubit>().updateDelayValue(delay - 5),
                      icon: Icon(Icons.remove, color: context.colorScheme.onSurface),
                      tooltip: t.staff.schedule_delay.decrease_delay_tooltip,
                    ),
                    const SizedBox(width: Spacing.m),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$delay ${t.staff.schedule_delay.delay_unit}',
                        style: context.getTextTheme(TextThemeType.monospace).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: Spacing.m),
                    IconButton.filledTonal(
                      onPressed: () => context.read<RoomCardCubit>().updateDelayValue(delay + 5),
                      icon: Icon(Icons.add, color: context.colorScheme.onSurface),
                      tooltip: t.staff.schedule_delay.increase_delay_tooltip,
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.m),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: hasChanges
                        ? () async {
                            final cubit = context.read<RoomCardCubit>();
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: Text(t.staff.schedule_delay.confirm_delay_dialog.title),
                                content: Text(
                                  t.staff.schedule_delay.confirm_delay_dialog.message
                                      .replaceAll('{delay}', delay.toString())
                                      .replaceAll('{room_name}', room.name),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(false),
                                    child: Text(t.common.buttons.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(true),
                                    child: Text(t.common.buttons.confirm),
                                  ),
                                ],
                              ),
                            );
                            if (result ?? false) {
                              await cubit.sendDelay();
                            }
                          }
                        : null,
                    child: Text(t.staff.schedule_delay.confirm_delay_button),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
