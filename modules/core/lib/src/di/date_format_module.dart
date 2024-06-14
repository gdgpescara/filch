import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@module
abstract class DateFormatModule {
  @lazySingleton
  @Named(DateFormatType.full)
  DateFormat get dateFormatFull => DateFormat('dd MMM yyyy • HH:mm');

  @lazySingleton
  @Named(DateFormatType.onlyDate)
  DateFormat get dateFormatDate => DateFormat('dd MMM yyyy');

  @lazySingleton
  @Named(DateFormatType.onlyTime)
  DateFormat get dateFormatTime => DateFormat('HH:mm');

  @lazySingleton
  @Named(DateFormatType.weekDay)
  DateFormat get dateFormatWeekDay => DateFormat('EEE');
}

class DateFormatType {
  static const full = 'full';
  static const onlyDate = 'onlyDate';
  static const onlyTime = 'onlyTime';
  static const weekDay = 'weekDay';
}
