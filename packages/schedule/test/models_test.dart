import 'package:flutter_test/flutter_test.dart';
import 'package:schedule/src/models/grouped_sessions.dart';
import 'package:schedule/src/models/named_entity.dart';
import 'package:schedule/src/models/session.dart';
import 'package:schedule/src/models/speaker.dart';
import 'package:schedule/src/models/speaker_link.dart';

void main() {
  group('Room Model', () {
    const roomJson = {'id': 215, 'name': 'Green Room'};

    test('should create Room from JSON', () {
      final room = Room.fromJson(roomJson);

      expect(room.id, 215);
      expect(room.name, 'Green Room');
    });

    test('should convert Room to JSON', () {
      const room = Room(id: 215, name: 'Green Room');
      final json = room.toJson();

      expect(json['id'], 215);
      expect(json['name'], 'Green Room');
    });

    test('should support copyWith functionality', () {
      const originalRoom = Room(id: 215, name: 'Green Room');
      final copiedRoom = originalRoom.copyWith(id: 216, name: 'Blue Room');

      expect(copiedRoom.id, 216);
      expect(copiedRoom.name, 'Blue Room');
      expect(originalRoom.id, 215); // unchanged
      expect(originalRoom.name, 'Green Room'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalRoom = Room(id: 215, name: 'Green Room');
      final copiedRoom = originalRoom.copyWith(name: 'Blue Room');

      expect(copiedRoom.id, 215); // unchanged
      expect(copiedRoom.name, 'Blue Room');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalRoom = Room(id: 215, name: 'Green Room');
      final copiedRoom = originalRoom.copyWith();

      expect(copiedRoom.id, 215);
      expect(copiedRoom.name, 'Green Room');
      expect(copiedRoom, equals(originalRoom));
    });

    test('should handle equality correctly', () {
      const room1 = Room(id: 215, name: 'Green Room');
      const room2 = Room(id: 215, name: 'Green Room');
      const room3 = Room(id: 216, name: 'Blue Room');

      expect(room1, equals(room2));
      expect(room1, isNot(equals(room3)));
    });

    test('should have correct props for Equatable', () {
      const room = Room(id: 215, name: 'Green Room');
      expect(room.props, [215, 'Green Room']);
    });
  });

  group('SpeakerLink Model', () {
    const speakerLinkJson = {'title': 'Twitter', 'url': 'https://twitter.com/sessionizecom', 'linkType': 'Twitter'};

    test('should create SpeakerLink from JSON', () {
      final link = SpeakerLink.fromJson(speakerLinkJson);

      expect(link.title, 'Twitter');
      expect(link.url, 'https://twitter.com/sessionizecom');
      expect(link.linkType, 'Twitter');
    });

    test('should convert SpeakerLink to JSON', () {
      const link = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      final json = link.toJson();

      expect(json['title'], 'Twitter');
      expect(json['url'], 'https://twitter.com/sessionizecom');
      expect(json['linkType'], 'Twitter');
    });

    test('should support copyWith functionality', () {
      const originalLink = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      final copiedLink = originalLink.copyWith(
        title: 'LinkedIn',
        url: 'https://linkedin.com/in/test',
        linkType: 'LinkedIn',
      );

      expect(copiedLink.title, 'LinkedIn');
      expect(copiedLink.url, 'https://linkedin.com/in/test');
      expect(copiedLink.linkType, 'LinkedIn');
      expect(originalLink.title, 'Twitter'); // unchanged
      expect(originalLink.url, 'https://twitter.com/sessionizecom'); // unchanged
      expect(originalLink.linkType, 'Twitter'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalLink = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      final copiedLink = originalLink.copyWith(title: 'Updated Twitter');

      expect(copiedLink.title, 'Updated Twitter');
      expect(copiedLink.url, 'https://twitter.com/sessionizecom');
      expect(copiedLink.linkType, 'Twitter');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalLink = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      final copiedLink = originalLink.copyWith();

      expect(copiedLink.title, 'Twitter');
      expect(copiedLink.url, 'https://twitter.com/sessionizecom');
      expect(copiedLink.linkType, 'Twitter');
      expect(copiedLink, equals(originalLink));
    });

    test('should handle equality correctly', () {
      const link1 = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      const link2 = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      const link3 = SpeakerLink(title: 'LinkedIn', url: 'https://linkedin.com/in/test', linkType: 'LinkedIn');

      expect(link1, equals(link2));
      expect(link1, isNot(equals(link3)));
    });

    test('should have correct props for Equatable', () {
      const link = SpeakerLink(title: 'Twitter', url: 'https://twitter.com/sessionizecom', linkType: 'Twitter');
      expect(link.props, ['Twitter', 'https://twitter.com/sessionizecom', 'Twitter']);
    });
  });

  group('Speaker Model', () {
    const speakerJson = {
      'id': '00000000-0000-0000-0000-000000000004',
      'fullName': 'Aiden Test',
      'bio': 'Pop culture fanatic. Friend of animals everywhere.',
      'tagLine': 'Professional public speaker',
      'profilePicture': 'https://sessionize.com/image/test.jpg',
      'links': [
        {'title': 'Twitter', 'url': 'https://twitter.com/sessionizecom', 'linkType': 'Twitter'},
        {'title': 'LinkedIn', 'url': 'http://linkedin.com/in/domagojpa', 'linkType': 'LinkedIn'},
      ],
    };

    test('should create Speaker from JSON', () {
      final speaker = Speaker.fromJson(speakerJson);

      expect(speaker.id, '00000000-0000-0000-0000-000000000004');
      expect(speaker.fullName, 'Aiden Test');
      expect(speaker.bio, 'Pop culture fanatic. Friend of animals everywhere.');
      expect(speaker.tagLine, 'Professional public speaker');
      expect(speaker.profilePicture, 'https://sessionize.com/image/test.jpg');
      expect(speaker.links, hasLength(2));
      expect(speaker.links?.first.title, 'Twitter');
      expect(speaker.links?.last.title, 'LinkedIn');
    });

    test('should convert Speaker to JSON', () {
      final speaker = Speaker.fromJson(speakerJson);
      final json = speaker.toJson();

      expect(json['id'], '00000000-0000-0000-0000-000000000004');
      expect(json['fullName'], 'Aiden Test');
      expect(json['bio'], 'Pop culture fanatic. Friend of animals everywhere.');
      expect(json['tagLine'], 'Professional public speaker');
      expect(json['profilePicture'], 'https://sessionize.com/image/test.jpg');
      expect(json['links'], isA<List<dynamic>>());
      expect(json['links'], hasLength(2));
    });

    test('should handle nullable fields correctly', () {
      const speaker = Speaker(
        id: 'test-id',
        fullName: 'Test Speaker',
        profilePicture: 'https://example.com/pic.jpg',
      );

      expect(speaker.bio, isNull);
      expect(speaker.tagLine, isNull);
      expect(speaker.links, isNull);
      expect(speaker.id, 'test-id');
      expect(speaker.fullName, 'Test Speaker');
      expect(speaker.profilePicture, 'https://example.com/pic.jpg');
    });

    test('should convert Speaker with null fields to JSON correctly', () {
      const speaker = Speaker(
        id: 'test-id',
        fullName: 'Test Speaker',
        profilePicture: 'https://example.com/pic.jpg',
      );

      final json = speaker.toJson();
      expect(json['id'], 'test-id');
      expect(json['fullName'], 'Test Speaker');
      expect(json['bio'], isNull);
      expect(json['tagLine'], isNull);
      expect(json['profilePicture'], 'https://example.com/pic.jpg');
      expect(json['links'], isNull);
    });

    test('should support copyWith functionality', () {
      final originalSpeaker = Speaker.fromJson(speakerJson);
      final copiedSpeaker = originalSpeaker.copyWith(fullName: 'Updated Name', bio: 'Updated bio');

      expect(copiedSpeaker.fullName, 'Updated Name');
      expect(copiedSpeaker.bio, 'Updated bio');
      expect(copiedSpeaker.id, originalSpeaker.id); // unchanged
      expect(copiedSpeaker.tagLine, originalSpeaker.tagLine); // unchanged
    });

    test('should support copyWith with partial updates', () {
      final originalSpeaker = Speaker.fromJson(speakerJson);
      final copiedSpeaker = originalSpeaker.copyWith(fullName: 'Updated Name');

      expect(copiedSpeaker.fullName, 'Updated Name');
      expect(copiedSpeaker.bio, originalSpeaker.bio); // unchanged
      expect(copiedSpeaker.id, originalSpeaker.id); // unchanged
      expect(copiedSpeaker.tagLine, originalSpeaker.tagLine); // unchanged
      expect(copiedSpeaker.profilePicture, originalSpeaker.profilePicture); // unchanged
      expect(copiedSpeaker.links, originalSpeaker.links); // unchanged
    });

    test('should return same instance with copyWith when no parameters provided', () {
      final originalSpeaker = Speaker.fromJson(speakerJson);
      final copiedSpeaker = originalSpeaker.copyWith();

      expect(copiedSpeaker.id, originalSpeaker.id);
      expect(copiedSpeaker.fullName, originalSpeaker.fullName);
      expect(copiedSpeaker.bio, originalSpeaker.bio);
      expect(copiedSpeaker.tagLine, originalSpeaker.tagLine);
      expect(copiedSpeaker.profilePicture, originalSpeaker.profilePicture);
      expect(copiedSpeaker.links, originalSpeaker.links);
      expect(copiedSpeaker, equals(originalSpeaker));
    });

    test('should handle equality correctly', () {
      final speaker1 = Speaker.fromJson(speakerJson);
      final speaker2 = Speaker.fromJson(speakerJson);
      final speaker3 = speaker1.copyWith(fullName: 'Different Name');

      expect(speaker1, equals(speaker2));
      expect(speaker1, isNot(equals(speaker3)));
    });

    test('should have correct props for Equatable', () {
      final speaker = Speaker.fromJson(speakerJson);
      expect(speaker.props, [
        speaker.id,
        speaker.fullName,
        speaker.bio,
        speaker.tagLine,
        speaker.profilePicture,
        speaker.links,
      ]);
    });

    test('should safely access nullable links', () {
      const speakerWithNullLinks = Speaker(
        id: 'test-id',
        fullName: 'Test Speaker',
        profilePicture: 'https://example.com/pic.jpg',
      );

      const speakerWithEmptyLinks = Speaker(
        id: 'test-id',
        fullName: 'Test Speaker',
        profilePicture: 'https://example.com/pic.jpg',
        links: <SpeakerLink>[],
      );

      // Test safe access to links
      expect(speakerWithNullLinks.links?.length, isNull);
      expect(speakerWithNullLinks.links?.isEmpty, isNull);
      expect(speakerWithEmptyLinks.links?.length, 0);
      expect(speakerWithEmptyLinks.links?.isEmpty, true);
    });
  });

  group('SessionFormat Model', () {
    const sessionFormatJson = {'id': 1111, 'name': 'Session'};

    test('should create SessionFormat from JSON', () {
      final format = SessionFormat.fromJson(sessionFormatJson);

      expect(format.id, 1111);
      expect(format.name, 'Session');
    });

    test('should convert SessionFormat to JSON', () {
      const format = SessionFormat(id: 1111, name: 'Session');
      final json = format.toJson();

      expect(json['id'], 1111);
      expect(json['name'], 'Session');
    });

    test('should support copyWith functionality', () {
      const originalFormat = SessionFormat(id: 1111, name: 'Session');
      final copiedFormat = originalFormat.copyWith(id: 2222, name: 'Workshop');

      expect(copiedFormat.id, 2222);
      expect(copiedFormat.name, 'Workshop');
      expect(originalFormat.id, 1111); // unchanged
      expect(originalFormat.name, 'Session'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalFormat = SessionFormat(id: 1111, name: 'Session');
      final copiedFormat = originalFormat.copyWith(name: 'Workshop');

      expect(copiedFormat.id, 1111);
      expect(copiedFormat.name, 'Workshop');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalFormat = SessionFormat(id: 1111, name: 'Session');
      final copiedFormat = originalFormat.copyWith();

      expect(copiedFormat.id, 1111);
      expect(copiedFormat.name, 'Session');
      expect(copiedFormat, equals(originalFormat));
    });

    test('should handle equality correctly', () {
      const format1 = SessionFormat(id: 1111, name: 'Session');
      const format2 = SessionFormat(id: 1111, name: 'Session');
      const format3 = SessionFormat(id: 2222, name: 'Workshop');

      expect(format1, equals(format2));
      expect(format1, isNot(equals(format3)));
    });

    test('should have correct props for Equatable', () {
      const format = SessionFormat(id: 1111, name: 'Session');
      expect(format.props, [1111, 'Session']);
    });
  });

  group('Track Model', () {
    const trackJson = {'id': 10663, 'name': 'Technical'};

    test('should create Track from JSON', () {
      final track = Track.fromJson(trackJson);

      expect(track.id, 10663);
      expect(track.name, 'Technical');
    });

    test('should convert Track to JSON', () {
      const track = Track(id: 10663, name: 'Technical');
      final json = track.toJson();

      expect(json['id'], 10663);
      expect(json['name'], 'Technical');
    });

    test('should support copyWith functionality', () {
      const originalTrack = Track(id: 10663, name: 'Technical');
      final copiedTrack = originalTrack.copyWith(id: 10664, name: 'Design');

      expect(copiedTrack.id, 10664);
      expect(copiedTrack.name, 'Design');
      expect(originalTrack.id, 10663); // unchanged
      expect(originalTrack.name, 'Technical'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalTrack = Track(id: 10663, name: 'Technical');
      final copiedTrack = originalTrack.copyWith(name: 'Design');

      expect(copiedTrack.id, 10663);
      expect(copiedTrack.name, 'Design');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalTrack = Track(id: 10663, name: 'Technical');
      final copiedTrack = originalTrack.copyWith();

      expect(copiedTrack.id, 10663);
      expect(copiedTrack.name, 'Technical');
      expect(copiedTrack, equals(originalTrack));
    });

    test('should handle equality correctly', () {
      const track1 = Track(id: 10663, name: 'Technical');
      const track2 = Track(id: 10663, name: 'Technical');
      const track3 = Track(id: 10664, name: 'Design');

      expect(track1, equals(track2));
      expect(track1, isNot(equals(track3)));
    });

    test('should have correct props for Equatable', () {
      const track = Track(id: 10663, name: 'Technical');
      expect(track.props, [10663, 'Technical']);
    });
  });

  group('Level Model', () {
    const levelJson = {'id': 1111, 'name': 'Intermediate'};

    test('should create Level from JSON', () {
      final level = Level.fromJson(levelJson);

      expect(level.id, 1111);
      expect(level.name, 'Intermediate');
    });

    test('should convert Level to JSON', () {
      const level = Level(id: 1111, name: 'Intermediate');
      final json = level.toJson();

      expect(json['id'], 1111);
      expect(json['name'], 'Intermediate');
    });

    test('should support copyWith functionality', () {
      const originalLevel = Level(id: 1111, name: 'Intermediate');
      final copiedLevel = originalLevel.copyWith(id: 2222, name: 'Advanced');

      expect(copiedLevel.id, 2222);
      expect(copiedLevel.name, 'Advanced');
      expect(originalLevel.id, 1111); // unchanged
      expect(originalLevel.name, 'Intermediate'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalLevel = Level(id: 1111, name: 'Intermediate');
      final copiedLevel = originalLevel.copyWith(name: 'Advanced');

      expect(copiedLevel.id, 1111);
      expect(copiedLevel.name, 'Advanced');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalLevel = Level(id: 1111, name: 'Intermediate');
      final copiedLevel = originalLevel.copyWith();

      expect(copiedLevel.id, 1111);
      expect(copiedLevel.name, 'Intermediate');
      expect(copiedLevel, equals(originalLevel));
    });

    test('should handle equality correctly', () {
      const level1 = Level(id: 1111, name: 'Intermediate');
      const level2 = Level(id: 1111, name: 'Intermediate');
      const level3 = Level(id: 2222, name: 'Advanced');

      expect(level1, equals(level2));
      expect(level1, isNot(equals(level3)));
    });

    test('should have correct props for Equatable', () {
      const level = Level(id: 1111, name: 'Intermediate');
      expect(level.props, [1111, 'Intermediate']);
    });
  });

  group('Language Model', () {
    const languageJson = {'id': 1111, 'name': 'Italian'};

    test('should create Language from JSON', () {
      final language = Language.fromJson(languageJson);

      expect(language.id, 1111);
      expect(language.name, 'Italian');
    });

    test('should convert Language to JSON', () {
      const language = Language(id: 1111, name: 'Italian');
      final json = language.toJson();

      expect(json['id'], 1111);
      expect(json['name'], 'Italian');
    });

    test('should support copyWith functionality', () {
      const originalLanguage = Language(id: 1111, name: 'Italian');
      final copiedLanguage = originalLanguage.copyWith(id: 2222, name: 'English');

      expect(copiedLanguage.id, 2222);
      expect(copiedLanguage.name, 'English');
      expect(originalLanguage.id, 1111); // unchanged
      expect(originalLanguage.name, 'Italian'); // unchanged
    });

    test('should support copyWith with partial updates', () {
      const originalLanguage = Language(id: 1111, name: 'Italian');
      final copiedLanguage = originalLanguage.copyWith(name: 'English');

      expect(copiedLanguage.id, 1111);
      expect(copiedLanguage.name, 'English');
    });

    test('should return same instance with copyWith when no parameters provided', () {
      const originalLanguage = Language(id: 1111, name: 'Italian');
      final copiedLanguage = originalLanguage.copyWith();

      expect(copiedLanguage.id, 1111);
      expect(copiedLanguage.name, 'Italian');
      expect(copiedLanguage, equals(originalLanguage));
    });

    test('should handle equality correctly', () {
      const language1 = Language(id: 1111, name: 'Italian');
      const language2 = Language(id: 1111, name: 'Italian');
      const language3 = Language(id: 2222, name: 'English');

      expect(language1, equals(language2));
      expect(language1, isNot(equals(language3)));
    });

    test('should have correct props for Equatable', () {
      const language = Language(id: 1111, name: 'Italian');
      expect(language.props, [1111, 'Italian']);
    });
  });

  group('GroupedSessions Model', () {
    late Map<DateTime, Map<DateTime, List<Session>>> sampleSessionsByDay;
    late GroupedSessions groupedSessions;

    setUp(() {
      final day1 = DateTime(2023, 9, 16);
      final day2 = DateTime(2023, 9, 17);
      final time1 = DateTime.parse('2023-09-16T09:00:00Z');
      final time2 = DateTime.parse('2023-09-16T14:00:00Z');
      final time3 = DateTime.parse('2023-09-17T09:00:00Z');

      final session1 = Session(
        id: '1',
        title: 'Session 1',
        description: 'Description 1',
        startsAt: time1,
        endsAt: time1.add(const Duration(hours: 1)),
        speakers: const [],
        room: const Room(id: 1, name: 'Room A'),
        sessionFormat: const SessionFormat(id: 1, name: 'Talk'),
        tracks: const [],
        tags: const [],
        level: const Level(id: 1, name: 'Beginner'),
        language: const Language(id: 1, name: 'English'),
      );

      final session2 = Session(
        id: '2',
        title: 'Session 2',
        description: 'Description 2',
        startsAt: time2,
        endsAt: time2.add(const Duration(hours: 1)),
        speakers: const [],
        room: const Room(id: 2, name: 'Room B'),
        sessionFormat: const SessionFormat(id: 1, name: 'Talk'),
        tracks: const [],
        tags: const [],
        level: const Level(id: 1, name: 'Beginner'),
        language: const Language(id: 1, name: 'English'),
      );

      final session3 = Session(
        id: '3',
        title: 'Session 3',
        description: 'Description 3',
        startsAt: time3,
        endsAt: time3.add(const Duration(hours: 1)),
        speakers: const [],
        room: const Room(id: 1, name: 'Room A'),
        sessionFormat: const SessionFormat(id: 1, name: 'Talk'),
        tracks: const [],
        tags: const [],
        level: const Level(id: 1, name: 'Beginner'),
        language: const Language(id: 1, name: 'English'),
      );

      sampleSessionsByDay = {
        day1: {
          time1: [session1],
          time2: [session2],
        },
        day2: {
          time3: [session3],
        },
      };

      groupedSessions = GroupedSessions(sessionsByDay: sampleSessionsByDay);
    });

    test('should create GroupedSessions with sessionsByDay', () {
      expect(groupedSessions.sessionsByDay, sampleSessionsByDay);
    });

    test('should get available days sorted chronologically', () {
      final availableDays = groupedSessions.availableDays;
      expect(availableDays, hasLength(2));
      expect(availableDays[0], DateTime(2023, 9, 16));
      expect(availableDays[1], DateTime(2023, 9, 17));
    });

    test('should get sessions for a specific day', () {
      final day1 = DateTime(2023, 9, 16);
      final sessionsForDay = groupedSessions.getSessionsForDay(day1);

      expect(sessionsForDay, isNotNull);
      expect(sessionsForDay!.length, 2); // 2 time slots
    });

    test('should return null for non-existent day', () {
      final nonExistentDay = DateTime(2023, 9, 18);
      final sessionsForDay = groupedSessions.getSessionsForDay(nonExistentDay);

      expect(sessionsForDay, isNull);
    });

    test('should get start times for a day sorted chronologically', () {
      final day1 = DateTime(2023, 9, 16);
      final startTimes = groupedSessions.getStartTimesForDay(day1);

      expect(startTimes, hasLength(2));
      expect(startTimes[0], DateTime.parse('2023-09-16T09:00:00Z'));
      expect(startTimes[1], DateTime.parse('2023-09-16T14:00:00Z'));
    });

    test('should return empty list for non-existent day start times', () {
      final nonExistentDay = DateTime(2023, 9, 18);
      final startTimes = groupedSessions.getStartTimesForDay(nonExistentDay);

      expect(startTimes, isEmpty);
    });

    test('should get sessions for specific day and time', () {
      final day1 = DateTime(2023, 9, 16);
      final time1 = DateTime.parse('2023-09-16T09:00:00Z');
      final sessions = groupedSessions.getSessionsForDayAndTime(day1, time1);

      expect(sessions, hasLength(1));
      expect(sessions.first.title, 'Session 1');
    });

    test('should return empty list for non-existent day and time', () {
      final nonExistentDay = DateTime(2023, 9, 18);
      final time = DateTime.parse('2023-09-18T09:00:00Z');
      final sessions = groupedSessions.getSessionsForDayAndTime(nonExistentDay, time);

      expect(sessions, isEmpty);
    });

    test('should return empty list for existing day but non-existent time', () {
      final day1 = DateTime(2023, 9, 16);
      final nonExistentTime = DateTime.parse('2023-09-16T16:00:00Z');
      final sessions = groupedSessions.getSessionsForDayAndTime(day1, nonExistentTime);

      expect(sessions, isEmpty);
    });

    test('should support copyWith functionality', () {
      final newSessionsByDay = <DateTime, Map<DateTime, List<Session>>>{};
      final copiedGroupedSessions = groupedSessions.copyWith(sessionsByDay: newSessionsByDay);

      expect(copiedGroupedSessions.sessionsByDay, newSessionsByDay);
      expect(copiedGroupedSessions.sessionsByDay, isNot(sampleSessionsByDay));
    });

    test('should return same instance with copyWith when no parameters provided', () {
      final copiedGroupedSessions = groupedSessions.copyWith();

      expect(copiedGroupedSessions.sessionsByDay, sampleSessionsByDay);
    });

    test('should handle equality correctly', () {
      final groupedSessions1 = GroupedSessions(sessionsByDay: sampleSessionsByDay);
      final groupedSessions2 = GroupedSessions(sessionsByDay: sampleSessionsByDay);
      const groupedSessions3 = GroupedSessions(sessionsByDay: {});

      expect(groupedSessions1, equals(groupedSessions2));
      expect(groupedSessions1, isNot(equals(groupedSessions3)));
    });

    test('should convert to and from JSON', () {
      final json = groupedSessions.toJson();
      final reconstructed = GroupedSessions.fromJson(json);

      expect(reconstructed, equals(groupedSessions));
      expect(reconstructed.sessionsByDay.length, groupedSessions.sessionsByDay.length);
    });

    test('should handle empty sessionsByDay', () {
      const emptyGroupedSessions = GroupedSessions(sessionsByDay: {});

      expect(emptyGroupedSessions.availableDays, isEmpty);
      expect(emptyGroupedSessions.getSessionsForDay(DateTime.now()), isNull);
      expect(emptyGroupedSessions.getStartTimesForDay(DateTime.now()), isEmpty);
      expect(emptyGroupedSessions.getSessionsForDayAndTime(DateTime.now(), DateTime.now()), isEmpty);
    });
  });

  group('Session Model', () {
    const sampleJson = {
      'id': '14022',
      'title': "Aiden's Keynote",
      'description': 'Usually, you would find a session description here.',
      'startsAt': '2023-09-16T09:00:00Z',
      'endsAt': '2023-09-16T10:00:00Z',
      'speakers': [
        {
          'id': '00000000-0000-0000-0000-000000000004',
          'fullName': 'Aiden Test',
          'bio': 'Pop culture fanatic.',
          'tagLine': 'Professional public speaker',
          'profilePicture': 'https://sessionize.com/image/test.jpg',
          'links': [
            {'title': 'Twitter', 'url': 'https://twitter.com/sessionizecom', 'linkType': 'Twitter'},
          ],
        },
      ],
      'room': {'id': 215, 'name': 'Green Room'},
      'sessionFormat': {'id': 1111, 'name': 'Session'},
      'tracks': [
        {'id': 10663, 'name': 'Technical'},
      ],
      'level': {'id': 1111, 'name': 'Intermediate'},
      'language': {'id': 1111, 'name': 'Italian'},
    };

    test('should create Session from JSON', () {
      final session = Session.fromJson(sampleJson);

      expect(session.id, '14022');
      expect(session.title, "Aiden's Keynote");
      expect(session.description, 'Usually, you would find a session description here.');
      expect(session.startsAt, DateTime.parse('2023-09-16T09:00:00Z'));
      expect(session.endsAt, DateTime.parse('2023-09-16T10:00:00Z'));
      expect(session.room.id, 215);
      expect(session.room.name, 'Green Room');
    });

    test('should convert Session to JSON', () {
      final session = Session.fromJson(sampleJson);
      final json = session.toJson();

      expect(json['id'], '14022');
      expect(json['title'], "Aiden's Keynote");
      expect(json['startsAt'], '2023-09-16T09:00:00.000Z');
      expect(json['endsAt'], '2023-09-16T10:00:00.000Z');
      expect((json['room'] as Map<String, dynamic>)['id'], 215);
      expect((json['room'] as Map<String, dynamic>)['name'], 'Green Room');
    });

    test('should calculate session duration correctly', () {
      final session = Session.fromJson(sampleJson);
      expect(session.duration, const Duration(hours: 1));
    });

    test('should determine if session has ended', () {
      final pastSession = Session.fromJson(sampleJson);
      expect(pastSession.hasEnded, true);

      final futureSession = pastSession.copyWith(
        startsAt: DateTime.now().add(const Duration(hours: 1)),
        endsAt: DateTime.now().add(const Duration(hours: 2)),
      );
      expect(futureSession.hasEnded, false);
    });

    test('should determine if session is currently running', () {
      final pastSession = Session.fromJson(sampleJson);
      expect(pastSession.isCurrentlyRunning, false);

      final currentSession = pastSession.copyWith(
        startsAt: DateTime.now().subtract(const Duration(minutes: 30)),
        endsAt: DateTime.now().add(const Duration(minutes: 30)),
      );
      expect(currentSession.isCurrentlyRunning, true);
    });

    test('should determine if session is upcoming', () {
      final pastSession = Session.fromJson(sampleJson);
      expect(pastSession.isUpcoming, false);

      final futureSession = pastSession.copyWith(
        startsAt: DateTime.now().add(const Duration(hours: 1)),
        endsAt: DateTime.now().add(const Duration(hours: 2)),
      );
      expect(futureSession.isUpcoming, true);
    });

    test('should support copyWith with all parameters', () {
      final originalSession = Session.fromJson(sampleJson);
      const newRoom = Room(id: 220, name: 'Blue Room');
      const newFormat = SessionFormat(id: 2222, name: 'Workshop');
      final newTracks = [const Track(id: 20001, name: 'Design')];
      const newLevel = Level(id: 2222, name: 'Advanced');
      const newLanguage = Language(id: 2222, name: 'English');
      final newSpeakers = <Speaker>[];

      final copiedSession = originalSession.copyWith(
        id: 'new-id',
        title: 'New Title',
        description: 'New Description',
        startsAt: DateTime.parse('2023-09-17T10:00:00Z'),
        endsAt: DateTime.parse('2023-09-17T11:00:00Z'),
        speakers: newSpeakers,
        room: newRoom,
        sessionFormat: newFormat,
        tracks: newTracks,
        level: newLevel,
        language: newLanguage,
      );

      expect(copiedSession.id, 'new-id');
      expect(copiedSession.title, 'New Title');
      expect(copiedSession.description, 'New Description');
      expect(copiedSession.startsAt, DateTime.parse('2023-09-17T10:00:00Z'));
      expect(copiedSession.endsAt, DateTime.parse('2023-09-17T11:00:00Z'));
      expect(copiedSession.speakers, newSpeakers);
      expect(copiedSession.room, newRoom);
      expect(copiedSession.sessionFormat, newFormat);
      expect(copiedSession.tracks, newTracks);
      expect(copiedSession.level, newLevel);
      expect(copiedSession.language, newLanguage);
    });

    test('should support copyWith with partial updates', () {
      final originalSession = Session.fromJson(sampleJson);
      final copiedSession = originalSession.copyWith(title: 'Updated Title');

      expect(copiedSession.title, 'Updated Title');
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

    test('should have correct props for Equatable', () {
      final session = Session.fromJson(sampleJson);
      expect(session.props, [
        session.id,
        session.title,
        session.description,
        session.startsAt,
        session.endsAt,
        session.speakers,
        session.room,
        session.sessionFormat,
        session.tracks,
        session.level,
        session.language,
      ]);
    });

    test('should handle edge case durations', () {
      final session = Session.fromJson(sampleJson);

      // Test same start and end time
      final instantSession = session.copyWith(
        startsAt: DateTime.parse('2023-09-16T09:00:00Z'),
        endsAt: DateTime.parse('2023-09-16T09:00:00Z'),
      );
      expect(instantSession.duration, Duration.zero);

      // Test multi-day session
      final multiDaySession = session.copyWith(
        startsAt: DateTime.parse('2023-09-16T23:00:00Z'),
        endsAt: DateTime.parse('2023-09-17T01:00:00Z'),
      );
      expect(multiDaySession.duration, const Duration(hours: 2));
    });
  });
}
