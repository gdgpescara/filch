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
    return BlocConsumer<RoomCardCubit, RoomCardState>(
      listener: (context, state) {
        if (state is RoomCardDelaySendError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.common.errors.generic)),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          RoomCardError() => Center(
            child: Text(
              t.common.errors.generic,
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.error),
            ),
          ),
          _ => _buildCardContent(context, state),
        };
      },
    );
  }

  Future<void> _onConfirmDelayPressed(BuildContext context, int delay) async {
    final cubit = context.read<RoomCardCubit>();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.staff.schedule_delay.confirm_delay_dialog.title),
        content: Text(
          t.staff.schedule_delay.confirm_delay_dialog.message(delay: delay, roomName: room.name),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(t.common.buttons.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(t.common.buttons.confirm),
          ),
        ],
      ),
    );
    if (result ?? false) {
      cubit.sendDelay();
    }
  }

  Widget _buildCardContent(BuildContext context, RoomCardState state) {
    final (delay, originalDelay, isLoading) = switch (state) {
      RoomCardLoaded(delay: final d, originalDelay: final o) => (d, o, false),
      RoomCardDelaySending(delay: final d, originalDelay: final o) => (d, o, true),
      RoomCardDelaySendError(delay: final d, originalDelay: final o) => (d, o, false),
      _ => (0, 0, false),
    };

    final hasChanges = delay != originalDelay;

    return AppCard(
      style: AppCardStyle.normal,
      padding: const EdgeInsets.all(Spacing.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoomHeader(room: room),
          const SizedBox(height: Spacing.m),
          _DelayControls(delay: delay, originalDelay: originalDelay),
          const SizedBox(height: Spacing.m),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: hasChanges && !isLoading ? () => _onConfirmDelayPressed(context, delay) : null,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(t.staff.schedule_delay.confirm_delay_button),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomHeader extends StatelessWidget {
  const _RoomHeader({required this.room});

  final NamedEntity room;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            room.name,
            style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          t.staff.schedule_delay.id_label(id: room.id),
          style: context.getTextTheme(TextThemeType.monospace).bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _DelayControls extends StatelessWidget {
  const _DelayControls({required this.delay, required this.originalDelay});

  final int delay;
  final int originalDelay;

  Color _getChipColor(BuildContext context) {
    return switch (delay.compareTo(originalDelay)) {
      1 => appColors.googleRed.brightnessColor(context).colorContainer,
      -1 => appColors.googleGreen.brightnessColor(context).colorContainer,
      _ => context.colorScheme.surfaceContainerHighest,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          onPressed: () => context.read<RoomCardCubit>().updateDelayValue(delay - 5),
          icon: Icon(Icons.remove, color: context.colorScheme.onSurface),
          tooltip: t.staff.schedule_delay.decrease_delay_tooltip,
        ),
        const SizedBox(width: Spacing.m),
        AppChip(
          color: _getChipColor(context),
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
          borderRadius: RadiusSize.m,
          child: Text(
            t.staff.schedule_delay.delay_unit(delay: delay),
            style: context.getTextTheme(TextThemeType.monospace).headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: Spacing.m),
        IconButton.filledTonal(
          onPressed: () => context.read<RoomCardCubit>().updateDelayValue(delay + 5),
          icon: Icon(Icons.add, color: context.colorScheme.onSurface),
          tooltip: t.staff.schedule_delay.increase_delay_tooltip,
        ),
      ],
    );
  }
}
