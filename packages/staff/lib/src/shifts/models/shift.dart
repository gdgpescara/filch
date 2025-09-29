import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'shift_locations_enum.dart';

part 'shift.g.dart';

@JsonSerializable(createToJson: false)
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

  @override
  List<Object?> get props => [user, start, duration, location, notes];
}

@JsonSerializable(createToJson: false)
class FirestoreUser extends Equatable {
  const FirestoreUser({required this.uid, this.displayName, required this.email, required this.photoUrl});

  factory FirestoreUser.fromJson(Map<String, dynamic> json) => _$FirestoreUserFromJson(json);

  final String uid;
  final String? displayName;
  final String email;
  final String photoUrl;

  @override
  List<Object?> get props => [uid, displayName, email, photoUrl];
}
