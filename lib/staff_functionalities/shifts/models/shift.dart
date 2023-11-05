import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common_functionalities/json_converters/timestamp_date_time_converter.dart';
import '../../../common_functionalities/user/models/firestore_user.dart';
import 'shift_locations_enum.dart';

part 'shift.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Shift extends Equatable {
  const Shift({
    required this.user,
    required this.start,
    required this.duration,
    required this.location,
    required this.notes,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  final FirestoreUser user;
  @TimestampDateTimeConverter()
  final DateTime start;
  final int duration;
  final ShiftLocationsEnum location;
  final String notes;

  Map<String, dynamic> toJson() => _$ShiftToJson(this);

  @override
  List<Object?> get props => [user, start, duration, location, notes];
}
