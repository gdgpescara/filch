import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

class DeloreanClock extends StatelessWidget {
  const DeloreanClock({super.key, required this.color, required this.date, required this.label});

  final Color color;
  final DateTime date;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: ${GetIt.I<DateFormat>(instanceName: DateFormatType.full).format(date)}',
      child: ExcludeSemantics(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _DigitalClockItem(date: date, color: color, digitalClockPart: _DigitalClockPart.month),
                  const Gap.horizontal(Spacing.s),
                  _DigitalClockItem(date: date, color: color, digitalClockPart: _DigitalClockPart.day),
                  const Gap.horizontal(Spacing.s),
                  _DigitalClockItem(date: date, color: color, digitalClockPart: _DigitalClockPart.year),
                  const Gap.horizontal(Spacing.m),
                  _AmPmItem(date: date, color: color),
                  const Gap.horizontal(Spacing.m),
                  _DigitalClockItem(date: date, color: color, digitalClockPart: _DigitalClockPart.hour),
                  const Gap.horizontal(Spacing.xs),
                  _DigitalText(text: ':', color: color),
                  _DigitalClockItem(date: date, color: color, digitalClockPart: _DigitalClockPart.minute),
                ],
              ),
              const Gap.vertical(Spacing.s),
              Text(label, style: context.getTextTheme(TextThemeType.themeSpecific).labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _AmPmItem extends StatelessWidget {
  const _AmPmItem({required this.date, required this.color});

  final DateTime date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isAM = GetIt.I<DateFormat>(instanceName: DateFormatType.amPm).format(date) == 'AM';
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(t.common.time.labels.am, style: context.getTextTheme(TextThemeType.themeSpecific).labelSmall),
        Icon(Icons.circle, color: isAM ? color : Colors.grey, size: 10),
        const Gap.vertical(Spacing.s),
        Text(t.common.time.labels.pm, style: context.getTextTheme(TextThemeType.themeSpecific).labelSmall),
        Icon(Icons.circle, color: isAM ? Colors.grey : color, size: 10),
      ],
    );
  }
}

class _DigitalClockItem extends StatelessWidget {
  const _DigitalClockItem({required this.date, required this.digitalClockPart, required this.color});

  final DateTime date;
  final _DigitalClockPart digitalClockPart;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final value = GetIt.I<DateFormat>(instanceName: digitalClockPart.formatType).format(date);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(digitalClockPart.label, style: context.getTextTheme(TextThemeType.themeSpecific).labelSmall),
        _DigitalText(text: value, color: color),
      ],
    );
  }
}

enum _DigitalClockPart {
  month(DateFormatType.month),
  day(DateFormatType.day),
  year(DateFormatType.year),
  hour(DateFormatType.hour),
  minute(DateFormatType.minute);

  const _DigitalClockPart(this.formatType);

  final String formatType;

  String get label {
    switch (this) {
      case _DigitalClockPart.month:
        return t.common.time.labels.month;
      case _DigitalClockPart.day:
        return t.common.time.labels.day;
      case _DigitalClockPart.year:
        return t.common.time.labels.year;
      case _DigitalClockPart.hour:
        return t.common.time.labels.hour;
      case _DigitalClockPart.minute:
        return t.common.time.labels.minute;
    }
  }
}

class _DigitalText extends StatelessWidget {
  const _DigitalText({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 28, color: color, fontWeight: FontWeight.bold, fontFamily: 'Digital'),
    );
  }
}
