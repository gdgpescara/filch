import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schedule/src/models/language.dart';
import 'package:schedule/src/models/level.dart';
import 'package:schedule/src/models/room.dart';
import 'package:schedule/src/models/session.dart';
import 'package:schedule/src/models/session_format.dart';
import 'package:schedule/src/models/speaker.dart';
import 'package:schedule/src/models/speaker_link.dart';
import 'package:schedule/src/models/track.dart';
import 'package:schedule/src/use_cases/get_session_by_id_use_case.dart';

void main() {
  group('GetSessionByIdUseCase', () {
    late FakeFirebaseFirestore fakeFirestore;
    late GetSessionByIdUseCase useCase;

    const sessionId = 'session123';
    
    final sessionData = {
      'title': 'Flutter Development',
      'description': 'Learn Flutter development',
      'startsAt': '2024-08-10T10:00:00.000Z',
      'endsAt': '2024-08-10T11:00:00.000Z',
      'speakers': [
        {
          'id': 'speaker1',
          'fullName': 'John Doe',
          'bio': 'Flutter expert',
          'tagLine': 'Senior Developer',
          'profilePicture': 'https://example.com/pic.jpg',
          'links': <Map<String, dynamic>>[],
        }
      ],
      'room': {'id': 1, 'name': 'Main Hall'},
      'sessionFormat': {'id': 1, 'name': 'Talk'},
      'tracks': [
        {'id': 1, 'name': 'Mobile Development'}
      ],
      'level': {'id': 1, 'name': 'Beginner'},
      'language': {'id': 1, 'name': 'English'},
    };

    final expectedSession = Session(
      id: sessionId,
      title: 'Flutter Development',
      description: 'Learn Flutter development',
      startsAt: DateTime.parse('2024-08-10T10:00:00.000Z'),
      endsAt: DateTime.parse('2024-08-10T11:00:00.000Z'),
      speakers: const [
        Speaker(
          id: 'speaker1',
          fullName: 'John Doe',
          bio: 'Flutter expert',
          tagLine: 'Senior Developer',
          profilePicture: 'https://example.com/pic.jpg',
          links: <SpeakerLink>[],
        )
      ],
      room: const Room(id: 1, name: 'Main Hall'),
      sessionFormat: const SessionFormat(id: 1, name: 'Talk'),
      tracks: const [Track(id: 1, name: 'Mobile Development')],
      level: const Level(id: 1, name: 'Beginner'),
      language: const Language(id: 1, name: 'English'),
    );

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      useCase = GetSessionByIdUseCase(fakeFirestore);
    });

    test('should return session when document exists', () async {
      // Arrange
      await fakeFirestore
          .collection('session')
          .doc(sessionId)
          .set(sessionData);

      // Act
      final result = useCase.call(sessionId);

      // Assert
      await expectLater(
        result,
        emits(expectedSession),
      );
    });

    test('should return null when document does not exist', () async {
      // Act
      final result = useCase.call('nonexistent-id');

      // Assert
      await expectLater(
        result,
        emits(null),
      );
    });

    test('should return null when document data is invalid', () async {
      // Arrange - set invalid data
      await fakeFirestore
          .collection('session')
          .doc(sessionId)
          .set({'invalid': 'data'});

      // Act
      final result = useCase.call(sessionId);

      // Assert
      await expectLater(
        result,
        emits(null),
      );
    });

    test('should return updated session when document is modified', () async {
      // Arrange - Create initial session
      await fakeFirestore
          .collection('session')
          .doc(sessionId)
          .set(sessionData);

      // Modify the data before testing
      await fakeFirestore
          .collection('session')
          .doc(sessionId)
          .update({'title': 'Updated Flutter Development'});

      // Act
      final result = useCase.call(sessionId);

      // Assert
      final expectedUpdatedSession = expectedSession.copyWith(
        title: 'Updated Flutter Development',
      );
      
      await expectLater(
        result,
        emits(expectedUpdatedSession),
      );
    });
  });
}
