import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schedule/src/models/grouped_sessions.dart';
import 'package:schedule/src/use_cases/get_grouped_sessions_use_case.dart';

void main() {
  group('GetGroupedSessionsUseCase', () {
    late FakeFirebaseFirestore fakeFirestore;
    late GetGroupedSessionsUseCase useCase;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      useCase = GetGroupedSessionsUseCase(fakeFirestore);
    });

    Map<String, dynamic> createSessionData({
      required String id,
      required String title,
      required String startsAt,
      required String endsAt,
      String description = 'Test Description',
      int roomId = 1,
      String roomName = 'Room A',
    }) {
      return {
        'id': id,
        'title': title,
        'description': description,
        'startsAt': startsAt,
        'endsAt': endsAt,
        'speakers': <Map<String, dynamic>>[],
        'room': {
          'id': roomId,
          'name': roomName,
        },
        'sessionFormat': {'id': 1, 'name': 'Talk'},
        'tracks': <Map<String, dynamic>>[],
        'level': {'id': 1, 'name': 'Beginner'},
        'language': {'id': 1, 'name': 'English'},
      };
    }

    group('when collection is empty', () {
      test('should return empty grouped sessions', () async {
        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) => groupedSessions.sessionsByDay.isEmpty)),
        );
      });
    });

    group('when collection has single session', () {
      test('should group single session correctly', () async {
        // Arrange
        final sessionData = createSessionData(
          id: 'session1',
          title: 'Morning Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );

        await fakeFirestore.collection('session').doc('session1').set(sessionData);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            final date = DateTime(2023, 9, 16);
            expect(groupedSessions.sessionsByDay.containsKey(date), true);
            final daySchedule = groupedSessions.getSessionsForDay(date);
            expect(daySchedule!.length, 1);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              date, 
              DateTime.parse('2023-09-16T09:00:00Z')
            );
            expect(sessions.length, 1);
            expect(sessions.first.title, 'Morning Session');
            return true;
          })),
        );
      });
    });

    group('when collection has multiple sessions', () {
      test('should group sessions by start time correctly', () async {
        // Arrange
        final session1Data = createSessionData(
          id: 'session1',
          title: 'Morning Session 1',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
          roomId: 1,
          roomName: 'Room A',
        );

        final session2Data = createSessionData(
          id: 'session2',
          title: 'Morning Session 2',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
          roomId: 2,
          roomName: 'Room B',
        );

        final session3Data = createSessionData(
          id: 'session3',
          title: 'Afternoon Session',
          startsAt: '2023-09-16T14:00:00Z',
          endsAt: '2023-09-16T15:00:00Z',
          roomId: 1,
          roomName: 'Room A',
        );

        await fakeFirestore.collection('session').doc('session1').set(session1Data);
        await fakeFirestore.collection('session').doc('session2').set(session2Data);
        await fakeFirestore.collection('session').doc('session3').set(session3Data);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1); // One day
            
            // Check morning sessions (same start time)
            final morningDay = DateTime(2023, 9, 16);
            expect(groupedSessions.sessionsByDay.containsKey(morningDay), true);
            
            // Check we have 2 different time slots on this day
            final daySchedule = groupedSessions.getSessionsForDay(morningDay);
            expect(daySchedule!.length, 2); // 2 different start times
            
            final morningTime = DateTime.parse('2023-09-16T09:00:00Z');
            final morningSessions = groupedSessions.getSessionsForDayAndTime(morningDay, morningTime);
            expect(morningSessions.length, 2);
            
            final morningTitles = morningSessions.map((session) => session.title).toList();
            expect(morningTitles, containsAll(['Morning Session 1', 'Morning Session 2']));
            
            // Check afternoon session
            final afternoonTime = DateTime.parse('2023-09-16T14:00:00Z');
            final afternoonSessions = groupedSessions.getSessionsForDayAndTime(morningDay, afternoonTime);
            expect(afternoonSessions.length, 1);
            expect(afternoonSessions.first.title, 'Afternoon Session');
            
            return true;
          })),
        );
      });

      test('should handle sessions on different days', () async {
        // Arrange
        final day1Session = createSessionData(
          id: 'session1',
          title: 'Day 1 Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );

        final day2Session = createSessionData(
          id: 'session2',
          title: 'Day 2 Session',
          startsAt: '2023-09-17T09:00:00Z',
          endsAt: '2023-09-17T10:00:00Z',
        );

        await fakeFirestore.collection('session').doc('session1').set(day1Session);
        await fakeFirestore.collection('session').doc('session2').set(day2Session);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 2);
            
            final day1 = DateTime(2023, 9, 16);
            final day2 = DateTime(2023, 9, 17);
            
            expect(groupedSessions.sessionsByDay.containsKey(day1), true);
            expect(groupedSessions.sessionsByDay.containsKey(day2), true);
            
            final day1Sessions = groupedSessions.getSessionsForDayAndTime(
              day1, 
              DateTime.parse('2023-09-16T09:00:00Z')
            );
            expect(day1Sessions.first.title, 'Day 1 Session');
            
            final day2Sessions = groupedSessions.getSessionsForDayAndTime(
              day2, 
              DateTime.parse('2023-09-17T09:00:00Z')
            );
            expect(day2Sessions.first.title, 'Day 2 Session');
            
            return true;
          })),
        );
      });

      test('should sort sessions within same time slot by room name', () async {
        // Arrange
        final sessionA = createSessionData(
          id: 'session1',
          title: 'Session in Room A',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
          roomId: 1,
          roomName: 'Room A',
        );

        final sessionB = createSessionData(
          id: 'session2',
          title: 'Session in Room B',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
          roomId: 2,
          roomName: 'Room B',
        );

        final sessionC = createSessionData(
          id: 'session3',
          title: 'Session in Room C',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
          roomId: 3,
          roomName: 'Room C',
        );

        // Add in reverse order to test sorting
        await fakeFirestore.collection('session').doc('session3').set(sessionC);
        await fakeFirestore.collection('session').doc('session2').set(sessionB);
        await fakeFirestore.collection('session').doc('session1').set(sessionA);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T09:00:00Z')
            );
            expect(sessions.length, 3);
            
            // Should be sorted by room name
            expect(sessions[0].room.name, 'Room A');
            expect(sessions[1].room.name, 'Room B');
            expect(sessions[2].room.name, 'Room C');
            
            return true;
          })),
        );
      });
    });

    group('when sessions have different time formats', () {
      test('should handle milliseconds in timestamps', () async {
        // Arrange
        final sessionData = createSessionData(
          id: 'session1',
          title: 'Session with milliseconds',
          startsAt: '2023-09-16T09:00:00.000Z',
          endsAt: '2023-09-16T10:00:00.000Z',
        );

        await fakeFirestore.collection('session').doc('session1').set(sessionData);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T09:00:00.000Z')
            );
            expect(sessions.length, 1);
            final session = sessions.first;
            expect(session.title, 'Session with milliseconds');
            expect(session.startsAt.hour, 9);
            expect(session.startsAt.minute, 0);
            return true;
          })),
        );
      });
    });

    group('when firestore returns invalid data', () {
      test('should handle sessions with missing required fields gracefully', () async {
        // Arrange - Add invalid session data directly to fake firestore
        await fakeFirestore.collection('session').doc('invalid').set({
          'title': 'Invalid Session',
          // Missing required fields like startsAt, endsAt, etc.
        });

        // Also add a valid session
        final validSession = createSessionData(
          id: 'valid',
          title: 'Valid Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );
        await fakeFirestore.collection('session').doc('valid').set(validSession);

        // Act
        final result = useCase.call();

        // Assert - Should only include valid sessions
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            // Should only have the valid session, invalid one should be filtered out
            expect(groupedSessions.sessionsByDay.length, 1);
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T09:00:00Z')
            );
            expect(sessions.length, 1);
            final session = sessions.first;
            expect(session.title, 'Valid Session');
            return true;
          })),
        );
      });
    });

    group('when firestore stream updates', () {
      test('should emit new data when sessions are added', () async {
        // Arrange
        final completer = Completer<void>();
        final results = <GroupedSessions>[];
        
        final subscription = useCase.call().listen((data) {
          results.add(data);
          if (results.length == 2) {
            completer.complete();
          }
        });

        // Initially empty
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Add a session
        final sessionData = createSessionData(
          id: 'session1',
          title: 'New Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );
        await fakeFirestore.collection('session').doc('session1').set(sessionData);

        // Wait for both emissions
        await completer.future.timeout(const Duration(seconds: 5));

        // Assert
        expect(results.length, 2);
        expect(results[0].sessionsByDay.isEmpty, true); // Initially empty
        expect(results[1].sessionsByDay.length, 1); // After adding session
        
        final day = DateTime(2023, 9, 16);
        final sessions = results[1].getSessionsForDayAndTime(
          day, 
          DateTime.parse('2023-09-16T09:00:00Z')
        );
        expect(sessions.first.title, 'New Session');

        await subscription.cancel();
      });

      test('should emit updated data when sessions are modified', () async {
        // Arrange
        final initialData = createSessionData(
          id: 'session1',
          title: 'Original Title',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );
        await fakeFirestore.collection('session').doc('session1').set(initialData);

        final completer = Completer<void>();
        final results = <GroupedSessions>[];
        
        final subscription = useCase.call().listen((data) {
          results.add(data);
          if (results.length == 2) {
            completer.complete();
          }
        });

        // Wait for initial data
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Update the session
        final updatedData = createSessionData(
          id: 'session1',
          title: 'Updated Title',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );
        await fakeFirestore.collection('session').doc('session1').set(updatedData);

        // Wait for update
        await completer.future.timeout(const Duration(seconds: 5));

        // Assert
        expect(results.length, 2);
        
        final day = DateTime(2023, 9, 16);
        final startTime = DateTime.parse('2023-09-16T09:00:00Z');
        
        final originalSessions = results[0].getSessionsForDayAndTime(day, startTime);
        expect(originalSessions.first.title, 'Original Title');
        
        final updatedSessions = results[1].getSessionsForDayAndTime(day, startTime);
        expect(updatedSessions.first.title, 'Updated Title');

        await subscription.cancel();
      });

      test('should emit updated data when sessions are deleted', () async {
        // Arrange
        final sessionData = createSessionData(
          id: 'session1',
          title: 'Session to Delete',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T10:00:00Z',
        );
        await fakeFirestore.collection('session').doc('session1').set(sessionData);

        final completer = Completer<void>();
        final results = <GroupedSessions>[];
        
        final subscription = useCase.call().listen((data) {
          results.add(data);
          if (results.length == 2) {
            completer.complete();
          }
        });

        // Wait for initial data
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Delete the session
        await fakeFirestore.collection('session').doc('session1').delete();

        // Wait for deletion
        await completer.future.timeout(const Duration(seconds: 5));

        // Assert
        expect(results.length, 2);
        expect(results[0].sessionsByDay.length, 1); // Initially has session
        expect(results[1].sessionsByDay.isEmpty, true); // After deletion

        await subscription.cancel();
      });
    });

    group('edge cases', () {
      test('should handle sessions with same start time but different durations', () async {
        // Arrange
        final shortSession = createSessionData(
          id: 'short',
          title: 'Short Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T09:30:00Z', // 30 minutes
        );

        final longSession = createSessionData(
          id: 'long',
          title: 'Long Session',
          startsAt: '2023-09-16T09:00:00Z',
          endsAt: '2023-09-16T11:00:00Z', // 2 hours
        );

        await fakeFirestore.collection('session').doc('short').set(shortSession);
        await fakeFirestore.collection('session').doc('long').set(longSession);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T09:00:00Z')
            );
            expect(sessions.length, 2);
            
            // Both should be grouped together despite different durations
            final titles = sessions.map((s) => s.title).toList();
            expect(titles, containsAll(['Short Session', 'Long Session']));
            
            return true;
          })),
        );
      });

      test('should handle midnight sessions correctly', () async {
        // Arrange
        final midnightSession = createSessionData(
          id: 'midnight',
          title: 'Midnight Session',
          startsAt: '2023-09-16T00:00:00Z',
          endsAt: '2023-09-16T01:00:00Z',
        );

        await fakeFirestore.collection('session').doc('midnight').set(midnightSession);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T00:00:00Z')
            );
            expect(sessions.length, 1);
            final session = sessions.first;
            expect(session.title, 'Midnight Session');
            expect(session.startsAt.hour, 0);
            return true;
          })),
        );
      });

      test('should handle sessions spanning multiple days', () async {
        // Arrange
        final spanningSession = createSessionData(
          id: 'spanning',
          title: 'Spanning Session',
          startsAt: '2023-09-16T23:00:00Z',
          endsAt: '2023-09-17T01:00:00Z', // Ends next day
        );

        await fakeFirestore.collection('session').doc('spanning').set(spanningSession);

        // Act
        final result = useCase.call();

        // Assert
        await expectLater(
          result,
          emits(predicate<GroupedSessions>((groupedSessions) {
            expect(groupedSessions.sessionsByDay.length, 1);
            final day = DateTime(2023, 9, 16);
            final sessions = groupedSessions.getSessionsForDayAndTime(
              day,
              DateTime.parse('2023-09-16T23:00:00Z')
            );
            expect(sessions.length, 1);
            final session = sessions.first;
            expect(session.title, 'Spanning Session');
            // Should be grouped by start time
            expect(session.startsAt.day, 16);
            expect(session.endsAt.day, 17);
            return true;
          })),
        );
      });
    });
  });
}
