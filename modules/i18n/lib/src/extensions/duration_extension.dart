import '../../i18n.dart';

typedef IntFormatter = String Function(int num);

extension DurationExtension on Duration {
  String format({
    IntFormatter? hoursFormatter,
    IntFormatter? minutesFormatter,
    IntFormatter? secondsFormatter,
  }) {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    if (hours > 0) {
      return hoursFormatter?.call(hours) ?? t.common.duration.hours(n: hours);
    }
    if (minutes > 0) {
      return minutesFormatter?.call(minutes) ?? t.common.duration.minutes(n: minutes);
    }
    return secondsFormatter?.call(seconds) ?? t.common.duration.seconds(n: seconds);
  }
}
