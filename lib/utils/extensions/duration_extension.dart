import '../../i18n/strings.g.dart';

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
      return hoursFormatter?.call(hours) ?? t.commons.duration.hours(n: hours);
    }
    if (minutes > 0) {
      return minutesFormatter?.call(minutes) ?? t.commons.duration.minutes(n: minutes);
    }
    return secondsFormatter?.call(seconds) ?? t.commons.duration.seconds(n: seconds);
  }
}
