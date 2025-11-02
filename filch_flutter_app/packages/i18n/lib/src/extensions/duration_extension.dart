import '../../i18n.dart';

typedef IntFormatter = String Function(int num);

extension DurationExtension on Duration {
  String format({IntFormatter? hoursFormatter, IntFormatter? minutesFormatter, IntFormatter? secondsFormatter}) {
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

  /// Converts the duration into a human-readable string with months, weeks, days, hours, minutes, and seconds
  ///
  /// Example: "1 mese • 2 settimane • 1 giorno • 5 minuti • 3 secondi"
  ///
  /// Only non-zero values are included in the output
  ///
  /// If [short] is true, uses abbreviated forms (e.g., "1 m • 2 sett • 1 g • 5 min • 3 s")
  ///
  /// If [onlyMostRelevant] is true, only shows the largest non-zero unit (e.g., "1 mese")
  String toHumanReadable({bool short = false, bool onlyMostRelevant = false}) {
    final parts = <String>[];

    var remaining = inSeconds;

    // Calculate months (approximated as 30 days)
    const secondsInMonth = 30 * 24 * 60 * 60;
    final months = remaining ~/ secondsInMonth;
    if (months > 0) {
      parts.add(short
          ? t.common.duration_short.months(n: months)
          : t.common.duration.months(n: months));
      if (onlyMostRelevant) return parts.first;
      remaining = remaining % secondsInMonth;
    }

    // Calculate weeks
    const secondsInWeek = 7 * 24 * 60 * 60;
    final weeks = remaining ~/ secondsInWeek;
    if (weeks > 0) {
      parts.add(short
          ? t.common.duration_short.weeks(n: weeks)
          : t.common.duration.weeks(n: weeks));
      if (onlyMostRelevant) return parts.first;
      remaining = remaining % secondsInWeek;
    }

    // Calculate days
    const secondsInDay = 24 * 60 * 60;
    final days = remaining ~/ secondsInDay;
    if (days > 0) {
      parts.add(short
          ? t.common.duration_short.days(n: days)
          : t.common.duration.days(n: days));
      if (onlyMostRelevant) return parts.first;
      remaining = remaining % secondsInDay;
    }

    // Calculate hours
    const secondsInHour = 60 * 60;
    final hours = remaining ~/ secondsInHour;
    if (hours > 0) {
      parts.add(short
          ? t.common.duration_short.hours(n: hours)
          : t.common.duration.hours(n: hours));
      if (onlyMostRelevant) return parts.first;
      remaining = remaining % secondsInHour;
    }

    // Calculate minutes
    const secondsInMinute = 60;
    final minutes = remaining ~/ secondsInMinute;
    if (minutes > 0) {
      parts.add(short
          ? t.common.duration_short.minutes(n: minutes)
          : t.common.duration.minutes(n: minutes));
      if (onlyMostRelevant) return parts.first;
      remaining = remaining % secondsInMinute;
    }

    // Calculate seconds
    final seconds = remaining;
    if (seconds > 0) {
      parts.add(short
          ? t.common.duration_short.seconds(n: seconds)
          : t.common.duration.seconds(n: seconds));
    }

    // If the duration is zero, return "0 seconds"
    if (parts.isEmpty) {
      return short
          ? t.common.duration_short.seconds(n: 0)
          : t.common.duration.seconds(n: 0);
    }

    return parts.join(' ');
  }
}
