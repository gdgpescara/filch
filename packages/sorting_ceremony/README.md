# Sorting Ceremony Package

Digital sorting ceremony package that assigns users to one of four tech houses (Pytherin, Kerasdor, Dashclaw, Gopherpuff) based on programming preferences and personality traits.

## Data Models

### House

Represents one of the four tech houses:

```dart
class House extends Equatable {
  final HouseType type;                   // House type enum
  final Map<String, String> name;         // Localized house name
  final Map<String, String> description;  // Localized house description
  final String color;                     // Primary house color
  final String technology;                // Primary technology focus
  final List<String> traits;             // House characteristic traits
  final String mascot;                    // House mascot/symbol
}
```

### HouseType

Tech house type enumeration:

- `pytherin` - House of Python developers (Data Science & AI)
- `kerasdor` - House of Keras/TensorFlow developers (Deep Learning)
- `dashclaw` - House of Dart/Flutter developers (Mobile Development)
- `gopherpuff` - House of Go developers (Backend & Systems)

### SortingQuestion

Question for the sorting ceremony quiz:

```dart
class SortingQuestion extends Equatable {
  final String id;                        // Question ID
  final Map<String, String> question;     // Localized question text
  final List<SortingAnswer> answers;      // Possible answers
  final int order;                        // Question order
  final QuestionType type;                // Question type
}
```

### SortingAnswer

Answer option for sorting questions:

```dart
class SortingAnswer extends Equatable {
  final String id;                        // Answer ID
  final Map<String, String> text;         // Localized answer text
  final Map<HouseType, int> housePoints;  // Points per house
  final String? explanation;              // Optional explanation
}
```

### SortingResult

Result of the sorting ceremony:

```dart
class SortingResult extends Equatable {
  final HouseType assignedHouse;          // Assigned house
  final Map<HouseType, int> houseScores;  // Scores for each house
  final DateTime sortedAt;                // When sorted
  final List<String> selectedAnswers;     // Selected answer IDs
  final double confidence;                // Confidence score (0.0-1.0)
}
```

## Use Cases

### UserNeedSortingCeremonyUseCase

Checks if a user needs to go through the sorting ceremony:

```dart
// Returns true if user needs sorting ceremony
bool call(User user) {
  return user.customClaims?['team'] == null;
}
```

### AssignTeamUseCase

Assigns a team to a user through Firebase Functions:

```dart
Future<String> call() async {
  // Calls Firebase Function to assign team
  // Returns assigned house name
}
```

## State Management

### SortingCeremonyCubit

Manages the sorting ceremony flow state:

**States:**

- `SortingCeremonyInitial` - Initial state
- `SortingCeremonyLoading` - Ceremony in progress
- `SortingCeremonySuccess` - Team assigned successfully
- `SortingCeremonyFailure` - Assignment failed

**Events:**

- `startSortingCeremony()` - Initiates the ceremony
- `reset()` - Resets to initial state

## Widgets

### SortingCeremonyPage

Main page for the sorting ceremony with:

- Introduction text and animations
- Start ceremony button
- Loading states during assignment
- Result display with assigned house
- Navigation to main app

## Firestore Collections

The sorting ceremony primarily uses Firebase Authentication custom claims but may also utilize:

### users

User documents with house assignment:

```dart
{
  'uid': 'user_id',                    // User ID (matches Firebase Auth)
  'team': 'pytherin',                  // Assigned house
  'team_assignment_date': Timestamp,   // Assignment timestamp
}
```

## Firebase Functions

### assign_team (Python)

Assigns a user to one of the four houses.

**Request:**

```dart
// No parameters required (uses authenticated user context)
```

**Response:**

```dart
String // Assigned house name ('pytherin', 'kerasdor', 'dashclaw', 'gopherpuff')
```

**Implementation:**

```python
@https_fn.on_call()
def assign_team(req: https_fn.CallableRequest) -> str:
    # 1. Verify user authentication
    if not req.auth:
        raise https_fn.HttpsError("unauthenticated", "User must be authenticated")
        
    uid = req.auth.uid
    
    # 2. Check if user already has a house assigned
    user = auth.get_user(uid)
    if user.custom_claims and 'team' in user.custom_claims:
        raise https_fn.HttpsError("already-exists", "User already has a house assigned")
    
    # 3. House assignment logic (random or criteria-based)
    houses = ["pytherin", "kerasdor", "dashclaw", "gopherpuff"]
    import random
    assigned_house = random.choice(houses)
    
    # 4. Update Firebase Auth custom claims
    auth.set_custom_user_claims(uid, {
        'team': assigned_house
    })
    
    # 5. Optional: Save to Firestore
    db = firestore.client()
    db.collection('users').document(uid).set({
        'team': assigned_house,
        'team_assignment_date': firestore.SERVER_TIMESTAMP
    }, merge=True)
    
    # 6. Return assigned house
    return assigned_house
```

## Tech Houses

The four houses are based on different programming technologies:

### 1. Pytherin

- **Focus**: Python programming and data science
- **Technology**: Python
- **Traits**: Analytical, methodical, data-driven
- **Color**: Green

### 2. Kerasdor

- **Focus**: AI and deep learning
- **Technology**: Keras/TensorFlow
- **Traits**: Innovative, intelligent, forward-thinking
- **Color**: Blue

### 3. Dashclaw

- **Focus**: Mobile development and UI
- **Technology**: Dart/Flutter
- **Traits**: Creative, user-focused, agile
- **Color**: Orange

### 4. Gopherpuff

- **Focus**: Backend systems and efficiency
- **Technology**: Go
- **Traits**: Reliable, efficient, systematic
- **Color**: Purple

## Exported Features

### Exported Models

- `House` - Tech house representation
- `HouseType` - House type enumeration
- `SortingQuestion` - Quiz question model
- `SortingAnswer` - Quiz answer model
- `SortingResult` - Ceremony result model

### Exported Use Cases

- `UserNeedSortingCeremonyUseCase` - Check if ceremony needed
- `AssignTeamUseCase` - Assign user to house

### Exported State Management

- `SortingCeremonyCubit` - Ceremony flow management

### Exported Widgets

- `SortingCeremonyPage` - Main ceremony interface

### Exported Constants

- `sortingCeremonyEnabled` - Feature flag

## Configuration

### Environment Variables

- `SORTING_CEREMONY_URL` - URL of the assign_team Firebase Function

### Feature Flag

The sorting ceremony can be enabled/disabled via:

```dart
const bool sortingCeremonyEnabled = true; // Set to false to disable
```

## Usage

### 1. Check if User Needs Ceremony

```dart
final needsCeremony = GetIt.instance<UserNeedSortingCeremonyUseCase>()
    .call(currentUser);

if (needsCeremony) {
  // Navigate to sorting ceremony
  Navigator.push(context, SortingCeremonyPage.route());
}
```

### 2. Start Ceremony

```dart
// In SortingCeremonyCubit
context.read<SortingCeremonyCubit>().startSortingCeremony();
```

### 3. Handle Results

```dart
BlocListener<SortingCeremonyCubit, SortingCeremonyState>(
  listener: (context, state) {
    if (state is SortingCeremonySuccess) {
      // Show assigned house: state.assignedHouse
    } else if (state is SortingCeremonyFailure) {
      // Handle error: state.error
    }
  },
  child: // Your UI
)
```

## Developer Notes

- Ensure Firebase Function is properly deployed and accessible
- Verify `SORTING_CEREMONY_URL` environment variable is set correctly
- Feature can be completely disabled by setting `sortingCeremonyEnabled = false`
- Error handling includes specific cases for already-assigned users
- Ceremony uses Firebase Auth custom claims for persistence
- UI includes loading animations and success/error states
