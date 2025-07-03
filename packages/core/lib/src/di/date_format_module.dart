import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@module
abstract class DateFormatModule {
  @lazySingleton
  @Named(DateFormatType.full)
  DateFormat get dateFormatFull => DateFormat('dd MMM yyyy • HH:mm');

  @lazySingleton
  @Named(DateFormatType.fullReadable)
  DateFormat get dateFormatFullReadable => DateFormat('dd MMM yyyy, HH:mm');

  @lazySingleton
  @Named(DateFormatType.onlyDate)
  DateFormat get dateFormatDate => DateFormat('dd MMM yyyy');

  @lazySingleton
  @Named(DateFormatType.onlyTime)
  DateFormat get dateFormatTime => DateFormat('HH:mm');

  @lazySingleton
  @Named(DateFormatType.weekDay)
  DateFormat get dateFormatWeekDay => DateFormat('EEE');

  @lazySingleton
  @Named(DateFormatType.year)
  DateFormat get dateFormatYear => DateFormat('yyyy');

  @lazySingleton
  @Named(DateFormatType.month)
  DateFormat get dateFormatMonth => DateFormat('MMM');

  @lazySingleton
  @Named(DateFormatType.day)
  DateFormat get dateFormatDay => DateFormat('dd');

  @lazySingleton
  @Named(DateFormatType.hour)
  DateFormat get dateFormatHour => DateFormat('hh');

  @lazySingleton
  @Named(DateFormatType.minute)
  DateFormat get dateFormatMinute => DateFormat('mm');

  @lazySingleton
  @Named(DateFormatType.amPm)
  DateFormat get dateFormatAmPm => DateFormat('a');
}

class DateFormatType {
  static const full = 'full';
  static const fullReadable = 'fullReadable';
  static const onlyDate = 'onlyDate';
  static const onlyTime = 'onlyTime';
  static const weekDay = 'weekDay';
  static const year = 'year';
  static const month = 'month';
  static const day = 'day';
  static const hour = 'hour';
  static const minute = 'minute';
  static const amPm = 'amPm';
}
