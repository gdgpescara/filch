import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';
import '../../../widgets/favorite_toggle_button.dart';
import '../../../widgets/session_progress.dart';

class SessionTime extends StatefulWidget {
  const SessionTime({super.key, required this.session});

  final Session session;

  @override
  State<SessionTime> createState() => _SessionTimeState();
}

class _SessionTimeState extends State<SessionTime> {
  Timer? _startTimer;
  Timer? _endTimer;

  @override
  void initState() {
    super.initState();
    _scheduleTimers();
  }

  @override
  void dispose() {
    _startTimer?.cancel();
    _endTimer?.cancel();
    super.dispose();
  }

  void _scheduleTimers() {
    final now = DateTime.now();

    // Schedule refresh at session start time
    if (now.isBefore(widget.session.startsAt)) {
      final timeUntilStart = widget.session.startsAt.difference(now);
      _startTimer = Timer(timeUntilStart, () {
        if (mounted) setState(() {});
      });
    }

    // Schedule refresh at session end time
    if (now.isBefore(widget.session.endsAt)) {
      final timeUntilEnd = widget.session.endsAt.difference(now);
      _endTimer = Timer(timeUntilEnd, () {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyTime);
    final startTime = dateFormatter.format(widget.session.startsAt);
    final endTime = dateFormatter.format(widget.session.endsAt);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timeSlot(startTime, endTime, context),
        if (widget.session.isCurrentlyRunning) ...[
          const SizedBox(height: Spacing.s),
          SessionProgress(session: widget.session),
        ],
      ],
    );
  }

  Row _timeSlot(
    String startTime,
    String endTime,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.schedule, size: 12),
              const SizedBox(width: Spacing.xs),
              Text('$startTime - $endTime', style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        if (widget.session.isUpcoming)
          AppChip(
            text: '${widget.session.durationInMinutes}min',
            color: appColors.googleBlue,
          ),
        if (widget.session.hasEnded)
          AppChip(
            text: t.schedule.sessions.session_status.ended,
            color: appColors.googleRed,
          ),
        if (!widget.session.isServiceSession) ...[
          const SizedBox(width: Spacing.s),
          FavoriteToggleButton(sessionId: widget.session.id),
        ],
      ],
    );
  }
}
