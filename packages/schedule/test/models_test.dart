import 'package:flutter_test/flutter_test.dart';
import 'package:schedule/src/models/session.dart';

void main() {
  group('Session Models', () {
    const sampleJson = {
      'id': '14022',
      'title': "Aiden's Keynote",
      'description': 'Usually, you would find a session description here. But, this is not a real session submission, so description is missing. Ha!',
      'startsAt': '2023-09-16T09:00:00Z',
      'endsAt': '2023-09-16T10:00:00Z',
      'speakers': [
        {
          'id': '00000000-0000-0000-0000-000000000004',
          'fullName': 'Aiden Test',
          'bio': 'Pop culture fanatic. Friend of animals everywhere. Student. Thinker. Bacon practitioner.',
          'tagLine': 'Professional public speaker',
          'profilePicture': 'https://sessionize.com/image/8db9-400o400o1-test4.jpg',
          'links': [
            {
              'title': 'Twitter',
              'url': 'https://twitter.com/sessionizecom',
              'linkType': 'Twitter'
            },
            {
              'title': 'LinkedIn',
              'url': 'http://linkedin.com/in/domagojpa',
              'linkType': 'LinkedIn'
            }
          ]
        }
      ],
      'roomId': 215,
      'room': 'Green Room',
      'sessionFormat': {
        'id': 1111,
        'name': 'Session'
      },
      'tracks': [
        {
          'id': 10663,
          'name': 'Technical'
        }
      ],
      'level': {
        'id': 1111,
        'name': 'Intermediate'
      },
      'language': {
        'id': 1111,
        'name': 'Italian'
      }
    };

    test('should create Session from JSON', () {
      final session = Session.fromJson(sampleJson);

      expect(session.id, '14022');
      expect(session.title, "Aiden's Keynote");
      expect(session.description, contains('Usually, you would find'));
      expect(session.startsAt, DateTime.parse('2023-09-16T09:00:00Z'));
      expect(session.endsAt, DateTime.parse('2023-09-16T10:00:00Z'));
      expect(session.roomId, 215);
      expect(session.room, 'Green Room');
    });

    test('should create Session with speakers', () {
      final session = Session.fromJson(sampleJson);

      expect(session.speakers, hasLength(1));
      final speaker = session.speakers.first;
      expect(speaker.id, '00000000-0000-0000-0000-000000000004');
      expect(speaker.fullName, 'Aiden Test');
      expect(speaker.bio, contains('Pop culture fanatic'));
      expect(speaker.tagLine, 'Professional public speaker');
      expect(speaker.profilePicture, contains('sessionize.com'));
      expect(speaker.links, hasLength(2));
    });

    test('should create Session with speaker links', () {
      final session = Session.fromJson(sampleJson);
      final speaker = session.speakers.first;

      expect(speaker.links.first.title, 'Twitter');
      expect(speaker.links.first.url, 'https://twitter.com/sessionizecom');
      expect(speaker.links.first.linkType, 'Twitter');

      expect(speaker.links.last.title, 'LinkedIn');
      expect(speaker.links.last.url, 'http://linkedin.com/in/domagojpa');
      expect(speaker.links.last.linkType, 'LinkedIn');
    });

    test('should create Session with format, tracks, level, and language', () {
      final session = Session.fromJson(sampleJson);

      expect(session.sessionFormat.id, 1111);
      expect(session.sessionFormat.name, 'Session');

      expect(session.tracks, hasLength(1));
      expect(session.tracks.first.id, 10663);
      expect(session.tracks.first.name, 'Technical');

      expect(session.level.id, 1111);
      expect(session.level.name, 'Intermediate');

      expect(session.language.id, 1111);
      expect(session.language.name, 'Italian');
    });

    test('should convert Session back to JSON', () {
      final session = Session.fromJson(sampleJson);
      final json = session.toJson();

      expect(json['id'], '14022');
      expect(json['title'], "Aiden's Keynote");
      expect(json['startsAt'], '2023-09-16T09:00:00.000Z');
      expect(json['endsAt'], '2023-09-16T10:00:00.000Z');
      expect(json['roomId'], 215);
      expect(json['room'], 'Green Room');
    });

    test('should calculate session duration', () {
      final session = Session.fromJson(sampleJson);
      expect(session.duration, const Duration(hours: 1));
    });

    test('should determine session status correctly', () {
      final pastSession = Session.fromJson(sampleJson);
      
      // All sample sessions are in the past (2023), so they should have ended
      expect(pastSession.hasEnded, true);
      expect(pastSession.isCurrentlyRunning, false);
      expect(pastSession.isUpcoming, false);
    });

    test('should support copyWith functionality', () {
      final originalSession = Session.fromJson(sampleJson);
      final copiedSession = originalSession.copyWith(
        title: 'Updated Title',
        room: 'Blue Room',
      );

      expect(copiedSession.title, 'Updated Title');
      expect(copiedSession.room, 'Blue Room');
      expect(copiedSession.id, originalSession.id); // unchanged
      expect(copiedSession.description, originalSession.description); // unchanged
    });

    test('should handle equality correctly', () {
      final session1 = Session.fromJson(sampleJson);
      final session2 = Session.fromJson(sampleJson);
      final session3 = session1.copyWith(title: 'Different Title');

      expect(session1, equals(session2));
      expect(session1, isNot(equals(session3)));
    });
  });
}
