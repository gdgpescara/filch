# Quests Package

Quest management system providing functionality for different types of quests including actor quests, quiz quests, social quests, and community challenges.

## Data Models

### Quest

Main quest model representing all quest types.

```dart
class Quest extends Equatable {
  final String id;
  final Map<String, String>? title;           // Localized titles
  final Map<String, String> description;      // Localized descriptions
  final List<int> points;                     // Points awarded per position
  final DateTime validityStart;              // Quest start time
  final DateTime validityEnd;                // Quest end time
  final Duration executionTime;              // Time limit for completion
  final QuestTypeEnum type;                  // Quest type (actor/quiz/social/community)
  
  // Actor Quest specific fields
  final Duration? queueTime;                 // Queue waiting time
  final String? actor;                       // Actor name/identifier
  final int? maxQueue;                       // Maximum queue size
  final int? groupSize;                      // Group size for quest
  final bool? requestAccepted;              // Whether request is accepted
  
  // Quiz Quest specific fields
  final String? qrCode;                     // QR code for quest activation
  final Map<String, String>? question;      // Localized question
  final List<Answer>? answers;              // Multiple choice answers
  
  // Social Quest specific fields
  final QuestSubTypeEnum? subType;          // Social quest subtype
  final String? verificationFunction;       // Function name for verification
}
```

### ActiveQuest

Represents a quest currently being executed by a user.

```dart
class ActiveQuest extends Equatable {
  final Quest quest;                        // The quest being executed
  final Map<String, String>? prompt;        // Localized prompt/instructions
  final DateTime activatedAt;              // When quest was activated
  
  Duration get remainingTime;              // Time remaining to complete
}
```

### Answer

Multiple choice answer for quiz quests.

```dart
class Answer extends Equatable {
  final Map<String, String> text;          // Localized answer text
  final bool isCorrect;                    // Whether this is correct answer
}
```

### QuestTypeEnum

- `actor` - Actor-led interactive quests
- `quiz` - Quiz/trivia quests  
- `social` - Social media integration quests
- `community` - Community photo/video challenges

### QuestSubTypeEnum

Social quest subtypes:
- `instagram` - Instagram post verification
- `linkedin` - LinkedIn post verification
- `twitter` - Twitter/X post verification

### Points

Points awarded for quest completion.

```dart
class Points extends Equatable {
  final PointsTypeEnum type;               // Type of points (quest/staff/community)
  final int points;                        // Points amount
  final String assignedBy;                // Who assigned the points
  final DateTime assignedAt;              // When points were assigned
  final String? quest;                    // Associated quest ID
}
```

### RankingItem

User ranking information.

```dart
class RankingItem extends Equatable {
  final String uid;                       // User ID
  final String? displayName;             // User display name
  final String? photoUrl;                // User photo URL
  final int totalPoints;                 // Total points earned
  final int position;                    // Ranking position
}
```

### AssignablePoints

Configuration for point assignment.

```dart
class AssignablePoints extends Equatable {
  final String id;
  final String name;                     // Point type name
  final int points;                      // Points amount
  final PointsTypeEnum type;            // Point type
}
```

## Use Cases

### Quest Management

- **SearchForQuestUseCase** - Find and assign next available quest
- **GetSignedUserQuestsUseCase** - Get user's completed quests
- **GetSignedUserActiveQuestUseCase** - Get user's current active quest
- **GiveUpQuestUseCase** - Abandon current quest
- **CanRequestForQuestUseCase** - Check if user can request new quest

### Quiz Functionality

- **ValidateQuizQrCodeUseCase** - Validate QR code for quiz activation
- **SubmitAnswerUseCase** - Submit quiz answer

### Social Quests

- **SocialQuestRegistrationUseCase** - Register social media activity

### Points & Ranking

- **GetSignedUserPointsUseCase** - Get user's points breakdown
- **GetRankingUseCase** - Get global ranking
- **GetYourRankingUseCase** - Get user's ranking details
- **GetYourRankingPositionUseCase** - Get user's current position
- **AssignPointsUseCase** - Assign points to users (staff only)
- **AssignTShirtUseCase** - Assign t-shirt pickup eligibility
- **GetAssignablePointsUseCase** - Get available point types for assignment
- **IsRankingFreezedUseCase** - Check if ranking is frozen

## Firebase Collections

### quests

Quest documents with the following structure:

```dart
{
  "id": "quest_identifier",
  "title": {
    "en": "English Title",
    "it": "Italian Title"
  },
  "description": {
    "en": "English Description", 
    "it": "Italian Description"
  },
  "points": [100, 75, 50, 25],
  "validityStart": Timestamp,
  "validityEnd": Timestamp,
  "executionTime": 1800, // seconds
  "type": "actor|quiz|social|community",
  "actor": "actor_name", // for actor quests
  "maxQueue": 10, // for actor quests
  "groupSize": 4, // for actor quests
  "qrCode": "qr_code_data", // for quiz quests
  "question": {
    "en": "Quiz question",
    "it": "Domanda quiz"
  },
  "answers": [
    {
      "text": {"en": "Answer 1", "it": "Risposta 1"},
      "isCorrect": true
    }
  ],
  "subType": "instagram|linkedin|twitter", // for social quests
  "verificationFunction": "function_name" // for social quests
}
```

### quests/{questId}/queue

Queue subcollection for actor quests:

```dart
{
  "userId": "user_id",
  "joinedAt": Timestamp,
  "position": 1,
  "status": "waiting|called|completed"
}
```

### users/{userId}/points

User points subcollection:

```dart
{
  "type": "quest|staff|community",
  "points": 100,
  "assignedBy": "staff_user_id",
  "assignedAt": Timestamp,
  "quest": "quest_id" // optional
}
```

### users/{userId}

User document includes:

```dart
{
  "activeQuest": {
    "quest": Quest, // embedded quest data
    "prompt": {"en": "Prompt", "it": "Prompt"},
    "activatedAt": Timestamp
  },
  "tShirtPickUpState": "none|requested|pickedUp"
}
```

### assignablePoints

Point type configurations:

```dart
{
  "id": "point_type_id",
  "name": "Point Type Name",
  "points": 50,
  "type": "staff|community"
}
```

## Firebase Functions

### searchForQuest

Finds and assigns the next available quest to the user.

**Request:** No parameters
**Response:**
```dart
{
  "success": true,
  "quest": ActiveQuest,
  "message": "Quest assigned successfully"
}
```

### submitAnswer

Submits quiz answer and assigns points if correct.

**Request:**
```dart
{
  "questId": "quest_id",
  "answers": ["answer1", "answer2"] // selected answers
}
```

**Response:**
```dart
{
  "success": true,
  "correct": true,
  "points": 100,
  "correctAnswers": ["answer1", "answer3"]
}
```

### assignPoints

Assigns points to users (staff only).

**Request:**
```dart
{
  "users": ["user_id1", "user_id2"],
  "points": 50,
  "type": "staff|community",
  "quest": "quest_id" // optional
}
```

**Response:**
```dart
{
  "success": true,
  "usersUpdated": 2
}
```

### removeActiveQuest

Removes user's active quest (give up functionality).

**Request:**
```dart
{
  "questId": "quest_id"
}
```

**Response:**
```dart
{
  "success": true,
  "message": "Quest removed successfully"
}
```

### scanOtherAttendee

Community quest for scanning other attendees.

**Request:**
```dart
{
  "targetUserId": "scanned_user_id"
}
```

**Response:**
```dart
{
  "success": true,
  "points": 25,
  "alreadyScanned": false
}
```

## Features

### Implemented Functionality

- Multi-type quest system (Actor, Quiz, Social, Community)
- Real-time quest queue management
- Points and ranking system
- QR code validation for quests
- Social media verification
- T-shirt pickup eligibility tracking
- Staff point assignment tools
- Quest abandonment
- Real-time ranking updates

### Exported Functionality

- Quest management use cases
- Points and ranking use cases
- Quest data models
- Points data models
- Quest type enums
- Social quest verification

## Dependencies

- `cloud_firestore` - Firestore database
- `cloud_functions` - Firebase Functions integration
- `core` - Shared utilities
- `auth` - Authentication integration

## Usage

```dart
import 'package:quests/quests.dart';

// Search for a new quest
final searchUseCase = GetIt.instance<SearchForQuestUseCase>();
final result = await searchUseCase(NoParams());
result.fold(
  (error) => print('Error: ${error.message}'),
  (activeQuest) => print('New quest: ${activeQuest.quest.title}'),
);

// Submit quiz answer
final submitUseCase = GetIt.instance<SubmitAnswerUseCase>();
final submitResult = await submitUseCase(
  SubmitAnswerParams(
    questId: 'quiz-123',
    answers: ['answer1', 'answer2'],
  ),
);

// Get user ranking
final rankingUseCase = GetIt.instance<GetRankingUseCase>();
final ranking = await rankingUseCase(NoParams());
```
