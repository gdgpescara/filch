import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import 'session_progress.dart';

class SessionTime extends StatefulWidget {
  const SessionTime({super.key, required this.startsAt, required this.endsAt});

  final DateTime startsAt;
  final DateTime endsAt;

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
    if (now.isBefore(widget.startsAt)) {
      final timeUntilStart = widget.startsAt.difference(now);
      _startTimer = Timer(timeUntilStart, () {
        if (mounted) setState(() {});
      });
    }

    // Schedule refresh at session end time
    if (now.isBefore(widget.endsAt)) {
      final timeUntilEnd = widget.endsAt.difference(now);
      _endTimer = Timer(timeUntilEnd, () {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyTime);
    final startTime = dateFormatter.format(widget.startsAt);
    final endTime = dateFormatter.format(widget.endsAt);
    final duration = widget.endsAt.difference(widget.startsAt);
    final durationMinutes = duration.inMinutes;
    final now = DateTime.now();
    final isInProgress = now.isAfter(widget.startsAt) && now.isBefore(widget.endsAt);
    final hasEnded = now.isAfter(widget.endsAt);
    final isFuture = now.isBefore(widget.startsAt);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timeSlot(startTime, endTime, context, isFuture, durationMinutes, hasEnded),
        if (isInProgress) ...[
          const SizedBox(height: Spacing.s),
          SessionProgress(startsAt: widget.startsAt, endsAt: widget.endsAt),
        ],
      ],
    );
  }

  Row _timeSlot(
    String startTime,
    String endTime,
    BuildContext context,
    bool isFuture,
    int durationMinutes,
    bool hasEnded,
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
        if (isFuture)
          AppChip(
            text: '${durationMinutes}min',
            color: appColors.googleBlue,
          ),
        if (hasEnded)
          AppChip(
            text: 'Terminato',
            color: appColors.googleRed,
          ),
      ],
    );
  }
}
