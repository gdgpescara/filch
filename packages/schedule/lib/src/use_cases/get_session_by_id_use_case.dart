import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../models/session.dart';
import 'get_max_room_delay_use_case.dart';
import 'get_user_favorite_session_ids_use_case.dart';

@lazySingleton
class GetSessionByIdUseCase {
  GetSessionByIdUseCase(
    this._firestore,
    this._getUserFavoriteSessionIdsUseCase,
    this._getMaxRoomDelayUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetUserFavoriteSessionIdsUseCase _getUserFavoriteSessionIdsUseCase;
  final GetMaxRoomDelayUseCase _getMaxRoomDelayUseCase;

  Stream<(Session, int)> call(String sessionId) {
    return runSafetyStream(() {
      return Rx.combineLatest3(
        _firestore.collection('sessions').doc(sessionId).snapshots(),
        _getUserFavoriteSessionIdsUseCase(),
        _getMaxRoomDelayUseCase(),
        (snapshot, favoriteIds, maxDelay) {
          final session = _parseSessionFromSnapshot(snapshot, favoriteIds, maxDelay);
          return (session, maxDelay);
        },
      );
    });
  }

  Session _parseSessionFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    Set<String> favoriteIds,
    int maxDelay,
  ) {
    final data = snapshot.data();
    if (!snapshot.exists || data == null) {
      throw NotFoundError();
    }

    try {
      final session = Session.fromJson({
        'id': snapshot.id,
        'realStartsAt': data['startsAt'],
        'realEndsAt': data['endsAt'],
        ...data,
      });
      return session.copyWith(
        isFavorite: favoriteIds.contains(session.id),
        realStartsAt: session.startsAt.add(Duration(minutes: maxDelay)),
        realEndsAt: session.endsAt.add(Duration(minutes: maxDelay)),
      );
    } catch (e) {
      throw GenericError(
        message: 'Failed to parse session data for ID ${snapshot.id}: $e',
      );
    }
  }
}
