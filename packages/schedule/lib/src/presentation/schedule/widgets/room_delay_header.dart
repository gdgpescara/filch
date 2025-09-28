import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class RoomDelayHeader extends StatelessWidget {
  const RoomDelayHeader({
    super.key,
    required this.roomDelay,
  });

  final int? roomDelay;

  @override
  Widget build(BuildContext context) {
    final delay = roomDelay ?? 0;

    if (delay <= 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: AppChip(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
        customColor: appColors.googleRed,
        child: Expanded(
          child: Text(
            t.schedule.sessions.room_delay.delay_message(delay: delay),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
