# Schedule Package

Event schedule management package providing functionality for viewing and managing DevFest Pescara event schedule, sessions, and speakers.

## Data Models

### Session

Event session information:

```dart
class Session extends Equatable {
  final String id;                          // Session ID
  final Map<String, String> title;          // Localized session title
  final Map<String, String> description;    // Localized session description
  final DateTime startTime;                 // Session start time
  final DateTime endTime;                   // Session end time
  final String room;                        // Room/location
  final SessionType type;                   // Session type
  final List<Speaker> speakers;             // Session speakers
  final List<String> tags;                  // Technology tags
  final String? slidesUrl;                  // Slides URL
  final String? videoUrl;                   // Video recording URL
  final bool isBookmarked;                  // User bookmark status
}
```

### Speaker

Speaker information:

```dart
class Speaker extends Equatable {
  final String id;                          // Speaker ID
  final String name;                        // Speaker name
  final String? title;                      // Job title
  final String? company;                    // Company name
  final Map<String, String>? bio;          // Localized speaker bio
  final String? photoUrl;                  // Speaker photo
  final List<SocialLink> socialLinks;      // Social media links
  final String? website;                   // Personal website
}
```

### SocialLink

Speaker social media links:

```dart
class SocialLink extends Equatable {
  final SocialPlatform platform;           // Platform type
  final String url;                        // Profile URL
  final String username;                   // Username/handle
}
```

### SessionType

Session type enumeration:

- `keynote` - Keynote presentation
- `talk` - Regular talk/presentation
- `workshop` - Hands-on workshop
- `panel` - Panel discussion
- `break` - Coffee break/lunch
- `networking` - Networking session

### SocialPlatform

Social media platform enumeration:

- `twitter` - Twitter/X
- `linkedin` - LinkedIn
- `github` - GitHub
- `website` - Personal website
- `instagram` - Instagram

### Room

Event room/location information:

```dart
class Room extends Equatable {
  final String id;                         // Room ID
  final String name;                       // Room name
  final String? description;               // Room description
  final int capacity;                      // Room capacity
  final String? location;                  // Physical location
  final List<String> equipment;           // Available equipment
}
```

## Use Cases

### Schedule Management

- **GetGroupedSessionsUseCase** - Get all sessions grouped by day and time
- **GetSessionByIdUseCase** - Get specific session by ID with real-time updates
- **GetSessionsByDayUseCase** - Get sessions for specific day
- **GetSessionsByRoomUseCase** - Get sessions for specific room
- **GetSessionsByTypeUseCase** - Get sessions by type
- **GetSessionDetailUseCase** - Get detailed session information
- **SearchSessionsUseCase** - Search sessions by title/speaker/tag

### Bookmark Management

- **BookmarkSessionUseCase** - Bookmark/unbookmark session
- **GetBookmarkedSessionsUseCase** - Get user's bookmarked sessions
- **IsSessionBookmarkedUseCase** - Check if session is bookmarked

### Speaker Management

- **GetSpeakersUseCase** - Get all speakers
- **GetSpeakerDetailUseCase** - Get detailed speaker information
- **GetSpeakerSessionsUseCase** - Get sessions by speaker

### Schedule Filtering

- **FilterSessionsByTagUseCase** - Filter sessions by technology tags
- **FilterSessionsByTimeUseCase** - Filter sessions by time range
- **GetCurrentSessionsUseCase** - Get currently running sessions
- **GetUpcomingSessionsUseCase** - Get upcoming sessions

## State Management

### ScheduleBloc

Manages schedule state and operations.

#### Schedule States

- **ScheduleInitial** - Initial state
- **ScheduleLoading** - Loading schedule data
- **ScheduleLoaded** - Schedule data loaded
- **ScheduleError** - Error loading schedule

#### Schedule Events

- **ScheduleLoadRequested** - Load schedule
- **ScheduleRefreshRequested** - Refresh schedule
- **ScheduleFilterChanged** - Change schedule filters
- **SessionBookmarkToggled** - Toggle session bookmark

### SessionBloc

Manages individual session state.

#### Session States

- **SessionInitial** - Initial state
- **SessionLoading** - Loading session
- **SessionLoaded** - Session loaded
- **SessionError** - Error loading session

#### Session Events

- **SessionLoadRequested** - Load session details
- **SessionBookmarkRequested** - Bookmark session
- **SessionShareRequested** - Share session

## Widgets

### ScheduleView

Main schedule view with day tabs and session list.

```dart
ScheduleView(
  sessions: sessions,
  selectedDay: DateTime.now(),
  onDayChanged: (day) => changeDay(day),
  onSessionTap: (session) => openSession(session),
  showBookmarksOnly: false,
)
```

### SessionCard

Session information card.

```dart
SessionCard(
  session: session,
  onTap: () => openSessionDetail(session),
  onBookmark: () => toggleBookmark(session),
  showSpeakers: true,
  showTime: true,
  showRoom: true,
)
```

### SpeakerCard

Speaker information card.

```dart
SpeakerCard(
  speaker: speaker,
  onTap: () => openSpeakerDetail(speaker),
  showBio: false,
  showCompany: true,
)
```

### SessionDetail

Detailed session view.

```dart
SessionDetail(
  session: session,
  onBookmark: () => toggleBookmark(session),
  onShare: () => shareSession(session),
  onSpeakerTap: (speaker) => openSpeaker(speaker),
)
```

### ScheduleFilter

Filter widget for schedule.

```dart
ScheduleFilter(
  selectedRoom: selectedRoom,
  selectedType: selectedType,
  selectedTags: selectedTags,
  onRoomChanged: (room) => filterByRoom(room),
  onTypeChanged: (type) => filterByType(type),
  onTagsChanged: (tags) => filterByTags(tags),
)
```

### TimelineView

Timeline view of sessions.

```dart
TimelineView(
  sessions: sessionsForDay,
  currentTime: DateTime.now(),
  onSessionTap: (session) => openSession(session),
  showNowIndicator: true,
)
```

## Firebase Collections

### sessions

Session documents:

```dart
{
  "id": "session_id",
  "title": {
    "en": "Building Scalable Flutter Apps",
    "it": "Costruire App Flutter Scalabili"
  },
  "description": {
    "en": "Learn how to build scalable Flutter applications",
    "it": "Impara come costruire applicazioni Flutter scalabili"
  },
  "startTime": Timestamp,
  "endTime": Timestamp,
  "room": "Main Stage",
  "type": "talk|workshop|keynote|panel",
  "speakers": ["speaker_id1", "speaker_id2"],
  "tags": ["flutter", "mobile", "architecture"],
  "slidesUrl": "https://slides.example.com",
  "videoUrl": "https://video.example.com",
  "level": "beginner|intermediate|advanced",
  "language": "en|it"
}
```

### speakers

Speaker documents:

```dart
{
  "id": "speaker_id",
  "name": "John Doe",
  "title": "Senior Flutter Developer",
  "company": "Tech Company",
  "bio": {
    "en": "John is a Senior Flutter Developer...",
    "it": "John è uno Sviluppatore Flutter Senior..."
  },
  "photoUrl": "https://photos.example.com/john.jpg",
  "socialLinks": [
    {
      "platform": "twitter",
      "url": "https://twitter.com/johndoe",
      "username": "@johndoe"
    },
    {
      "platform": "linkedin", 
      "url": "https://linkedin.com/in/johndoe",
      "username": "johndoe"
    }
  ],
  "website": "https://johndoe.dev"
}
```

### rooms

Room configuration:

```dart
{
  "id": "room_id",
  "name": "Main Stage",
  "description": "Main conference room",
  "capacity": 300,
  "location": "Ground floor",
  "equipment": ["projector", "microphone", "live_stream"]
}
```

### users/{userId}/bookmarks

User bookmarked sessions:

```dart
{
  "sessionId": "session_id",
  "bookmarkedAt": Timestamp,
  "reminder": boolean
}
```

## Features

### Implemented Functionality

- Complete event schedule viewing
- Session detail pages with speaker information
- Session bookmarking system
- Speaker profiles and social links
- Schedule filtering and search
- Real-time schedule updates
- Multi-language session content
- Timeline view of sessions
- Room-based schedule view
- Technology tag filtering

### Exported Functionality

- Schedule management use cases
- Session and speaker use cases
- Bookmark management use cases
- Schedule state management (Bloc)
- Schedule viewing widgets
- Session and speaker components
- Schedule data models

### Schedule Features

- Day-by-day schedule view
- Real-time session status
- Conflict detection for bookmarks
- Session reminders
- Speaker social media integration
- Session rating and feedback
- Schedule export functionality

## Navigation

### Deep Linking

The package supports deep linking for:

- `/schedule` - Main schedule view
- `/schedule/session/{sessionId}` - Session detail
- `/schedule/speaker/{speakerId}` - Speaker detail
- `/schedule/day/{date}` - Specific day schedule

## Dependencies

- `cloud_firestore` - Firestore database
- `flutter_bloc` - State management
- `core` - Shared utilities
- `i18n` - Internationalization
- `ui` - UI components

## Usage

```dart
import 'package:schedule/schedule.dart';

// Get all sessions grouped by day and time
final groupedSessionsUseCase = GetIt.instance<GetGroupedSessionsUseCase>();
groupedSessionsUseCase().listen((groupedSessions) {
  print('Sessions by day: ${groupedSessions.sessionsByDay.keys.length}');
});

// Get specific session by ID with real-time updates
final getSessionByIdUseCase = GetIt.instance<GetSessionByIdUseCase>();
getSessionByIdUseCase('session_123').listen((session) {
  if (session != null) {
    print('Session found: ${session.title}');
    print('Status: ${session.isCurrentlyRunning ? "Running" : "Not running"}');
  } else {
    print('Session not found or invalid data');
  }
});

// Bookmark session
final bookmarkUseCase = GetIt.instance<BookmarkSessionUseCase>();
await bookmarkUseCase(BookmarkSessionParams(sessionId: 'session_123'));

// Monitor schedule state
BlocBuilder<ScheduleBloc, ScheduleState>(
  builder: (context, state) {
    if (state is ScheduleLoaded) {
      return ScheduleView(sessions: state.sessions);
    } else if (state is ScheduleLoading) {
      return LoadingWidget();
    }
    return ErrorWidget();
  },
)

// Session detail
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SessionDetailPage(sessionId: session.id),
  ),
);

// Filter sessions
final filteredSessions = sessions.where((session) => 
  session.tags.contains('flutter') &&
  session.type == SessionType.talk
).toList();
```
