import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../quests/models/active_quest.dart';

part 'firestore_user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FirestoreUser extends Equatable {
  const FirestoreUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.activeQuest,
  });

  factory FirestoreUser.fromJson(Map<String, dynamic> json) => _$FirestoreUserFromJson(json);

  @JsonKey(includeToJson: false)
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final ActiveQuest? activeQuest;

  FirestoreUser removeActiveQuest() {
    return FirestoreUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      activeQuest: null,
    );
  }

  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        activeQuest,
      ];
}
