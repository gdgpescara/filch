import 'package:json_annotation/json_annotation.dart';

class IntDurationConverter implements JsonConverter<Duration, int> {
  const IntDurationConverter();

  @override
  Duration fromJson(int json) {
    return Duration(minutes: json);
  }

  @override
  int toJson(Duration object) {
    return object.inMinutes;
  }
}
