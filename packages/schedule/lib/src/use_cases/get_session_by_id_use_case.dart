import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/session.dart';
import 'get_user_favorite_session_ids_use_case.dart';

@lazySingleton
class GetSessionByIdUseCase {
  GetSessionByIdUseCase(
    this._firestore,
    this._getUserFavoriteSessionIdsUseCase,
  );

  final FirebaseFirestore _firestore;
  final GetUserFavoriteSessionIdsUseCase _getUserFavoriteSessionIdsUseCase;

  /// Retrieves a session by its ID with favorite status
  ///
  /// Returns a [Stream<Session>] that emits the session data when found.
  /// Throws [NotFoundError] if the session doesn't exist.
  /// The stream will update automatically if the session data or favorite status changes.
  Stream<Session> call(String sessionId) {
    return runSafetyStream(() {
      late StreamController<Session> controller;
      StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? sessionSub;
      StreamSubscription<Set<String>>? favoritesSub;

      var favoriteIds = <String>{};
      DocumentSnapshot<Map<String, dynamic>>? latestSnapshot;

      void emitSession() {
        final snapshot = latestSnapshot;
        if (snapshot == null) return;

        try {
          final session = _parseSessionFromSnapshot(snapshot, favoriteIds);
          controller.add(session);
        } catch (error) {
          controller.addError(error);
        }
      }

      void handleError(Object error) {
        controller.addError(error);
      }

      controller = StreamController<Session>(
        onListen: () {
          favoritesSub = _getUserFavoriteSessionIdsUseCase().listen(
            (ids) {
              favoriteIds = ids;
              emitSession();
            },
            onError: handleError,
          );

          sessionSub = _firestore.collection('sessions').doc(sessionId).snapshots().listen(
            (snapshot) {
              latestSnapshot = snapshot;
              emitSession();
            },
            onError: handleError,
          );
        },
        onCancel: () {
          sessionSub?.cancel();
          favoritesSub?.cancel();
        },
      );

      return controller.stream;
    });
  }

  /// Parses a Firestore document snapshot into a Session object with favorite status
  Session _parseSessionFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    Set<String> favoriteIds,
  ) {
    if (!snapshot.exists || snapshot.data() == null) {
      throw NotFoundError();
    }

    try {
      final session = Session.fromJson({
        'id': snapshot.id,
        ...snapshot.data()!,
      });
      return session.copyWith(isFavorite: favoriteIds.contains(session.id));
    } catch (e) {
      throw GenericError(
        message: 'Failed to parse session data for ID ${snapshot.id}: $e',
      );
    }
  }
}
