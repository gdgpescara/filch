import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class SessionProgress extends StatefulWidget {
  const SessionProgress({
    super.key,
    required this.sessionDuration,
    required this.startsAt,
    required this.endsAt,
  });

  final Duration sessionDuration;
  final DateTime startsAt;
  final DateTime endsAt;

  @override
  State<SessionProgress> createState() => _SessionProgressState();
}

class _SessionProgressState extends State<SessionProgress> {
  late final Ticker _ticker;
  late final ValueNotifier<double> _progressNotifier;
  late final ValueNotifier<(int minutes, int seconds)> _timeNotifier;

  double get _progress {
    final now = DateTime.now();
    final totalDuration = widget.sessionDuration.inMilliseconds;
    final elapsed = now.difference(widget.startsAt).inMilliseconds;
    return (elapsed / totalDuration).clamp(0.0, 1.0);
  }

  (int, int) get _remainingTime {
    final now = DateTime.now();
    final remaining = widget.endsAt.difference(now);
    return (remaining.inMinutes, remaining.inSeconds % 60);
  }

  @override
  void initState() {
    super.initState();
    _progressNotifier = ValueNotifier(_progress);
    _timeNotifier = ValueNotifier(_remainingTime);
    _ticker = Ticker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _progressNotifier.dispose();
    _timeNotifier.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    _progressNotifier.value = _progress;
    _timeNotifier.value = _remainingTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.play_circle_filled,
              size: 12,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: Spacing.xs),
            Text(
              t.schedule.sessions.session_progress.in_progress_label,
              style: context
                  .getTextTheme(TextThemeType.monospace)
                  .bodySmall
                  ?.copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            ValueListenableBuilder<(int, int)>(
              valueListenable: _timeNotifier,
              builder: (context, time, child) {
                return Text(
                  t.schedule.sessions.session_progress.remaining_time(minutes: time.$1, seconds: time.$2),
                  style: context.getTextTheme(TextThemeType.monospace).bodySmall?.copyWith(fontWeight: FontWeight.w600),
                );
              },
            ),
          ],
        ),
        const Gap.vertical(Spacing.xs),
        ValueListenableBuilder<double>(
          valueListenable: _progressNotifier,
          builder: (context, progress, child) {
            return LinearProgressIndicator(value: progress);
          },
        ),
      ],
    );
  }
}
