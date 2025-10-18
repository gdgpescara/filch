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
    if (now.isBefore(widget.session.realStartsAt)) {
      final timeUntilStart = widget.session.realStartsAt.difference(now);
      _startTimer = Timer(timeUntilStart, () {
        if (mounted) setState(() {});
      });
    }

    // Schedule refresh at session end time
    if (now.isBefore(widget.session.realEndsAt)) {
      final timeUntilEnd = widget.session.realEndsAt.difference(now);
      _endTimer = Timer(timeUntilEnd, () {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timeSlot(context),
        if (widget.session.isCurrentlyRunning) ...[
          const Gap.vertical(Spacing.s),
          SessionProgress(
            sessionDuration: widget.session.duration,
            startsAt: widget.session.realStartsAt,
            endsAt: widget.session.realEndsAt,
          ),
        ],
      ],
    );
  }

  Row _timeSlot(BuildContext context) {
    final dateFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyTime);
    final hasDelay = !widget.session.startsAt.isAtSameMomentAs(widget.session.realStartsAt);
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.schedule, size: 12),
              const SizedBox(width: Spacing.xs),
              Column(
                children: [
                  Text(
                    '${dateFormatter.format(widget.session.startsAt)} - ${dateFormatter.format(widget.session.endsAt)}',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: hasDelay && !widget.session.isEnded ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (hasDelay && !widget.session.isEnded)
                    Text(
                      '${dateFormatter.format(widget.session.realStartsAt)} - ${dateFormatter.format(widget.session.realEndsAt)}',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: appColors.googleRed.seed,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (widget.session.isUpcoming)
          AppChip(
            text: '${widget.session.durationInMinutes}min',
            customColor: appColors.googleBlue,
          ),
        if (widget.session.isEnded)
          AppChip(
            text: t.schedule.sessions.session_status.ended,
            customColor: appColors.googleRed,
          ),
        if (!widget.session.isServiceSession) ...[
          const SizedBox(width: Spacing.s),
          FavoriteToggleButton(session: widget.session),
        ],
      ],
    );
  }
}
