# User Package

User management package handling user profiles, points tracking, and user-related functionality.

## Data Models

### TShirtPickUpState

Enum representing t-shirt pickup status:

- `none` - No t-shirt requested
- `requested` - T-shirt pickup requested  
- `pickedUp` - T-shirt already picked up

### UserProfile

User profile information (embedded in Firestore user document):

```dart
{
  "uid": "firebase_user_id",
  "displayName": "User Display Name",
  "email": "user@example.com", 
  "photoURL": "profile_photo_url",
  "tShirtPickUpState": "none|requested|pickedUp",
  "activeQuest": ActiveQuest?, // Current quest if any
  "createdAt": Timestamp,
  "lastActive": Timestamp
}
```

## Use Cases

### Profile Management

- **GetUserProfileUseCase** - Get user profile information
- **UpdateUserProfileUseCase** - Update user profile data
- **GetCurrentUserUseCase** - Get current authenticated user

### Points Management

- **GetUserPointsUseCase** - Get user's points breakdown
- **GetUserTotalPointsUseCase** - Get user's total points
- **GetUserPointsHistoryUseCase** - Get chronological points history

### T-Shirt Management

- **RequestTShirtPickUpUseCase** - Request t-shirt pickup eligibility
- **GetTShirtEligibilityUseCase** - Check t-shirt pickup eligibility
- **UpdateTShirtStatusUseCase** - Update pickup status (staff only)

### Home Dashboard

- **GetUserDashboardDataUseCase** - Get aggregated dashboard data
- **GetUserStatsUseCase** - Get user statistics
- **GetUserAchievementsUseCase** - Get user achievements/badges

## State Management

### UserBloc

Manages user profile state.

#### States

- **UserInitial** - Initial state
- **UserLoading** - Loading user data
- **UserLoaded** - User data loaded
- **UserError** - Error loading user data

#### Events

- **UserLoadRequested** - Load user profile
- **UserUpdateRequested** - Update user profile
- **UserPointsRefreshRequested** - Refresh points data

### PointsBloc

Manages user points state.

#### States

- **PointsInitial** - Initial state
- **PointsLoading** - Loading points
- **PointsLoaded** - Points data loaded
- **PointsError** - Error loading points

#### Events

- **PointsLoadRequested** - Load user points
- **PointsRefreshRequested** - Refresh points data

## Widgets

### UserProfileWidget

Display user profile information with avatar, name, and stats.

```dart
UserProfileWidget(
  user: currentUser,
  showStats: true,
  onTap: () => navigateToProfile(),
)
```

### PointsDisplayWidget

Show user's points breakdown and total.

```dart
PointsDisplayWidget(
  totalPoints: userPoints.total,
  pointsBreakdown: userPoints.breakdown,
  showDetails: true,
)
```

### TShirtStatusWidget

Display t-shirt pickup status and eligibility.

```dart
TShirtStatusWidget(
  status: TShirtPickUpState.requested,
  onRequestPickup: () => requestTShirt(),
)
```

### UserStatsWidget

Show user statistics and achievements.

```dart
UserStatsWidget(
  questsCompleted: 15,
  totalPoints: 850,
  ranking: 42,
  achievements: userAchievements,
)
```

## Firebase Collections

### users/{userId}

Main user document:

```dart
{
  "uid": "firebase_user_id",
  "email": "user@example.com",
  "displayName": "User Display Name", 
  "photoURL": "profile_photo_url",
  "tShirtPickUpState": "none|requested|pickedUp",
  "activeQuest": {
    "quest": Quest,
    "prompt": {"en": "Prompt", "it": "Prompt"},
    "activatedAt": Timestamp
  },
  "createdAt": Timestamp,
  "lastActive": Timestamp,
  "preferences": {
    "language": "en|it",
    "notifications": boolean
  }
}
```

### users/{userId}/points

Points subcollection:

```dart
{
  "type": "quest|staff|community",
  "points": 100,
  "assignedBy": "staff_user_id",
  "assignedAt": Timestamp,
  "quest": "quest_id", // optional
  "description": "Point description"
}
```

### users/{userId}/achievements

Achievements subcollection:

```dart
{
  "id": "achievement_id",
  "name": "Achievement Name",
  "description": "Achievement Description", 
  "unlockedAt": Timestamp,
  "icon": "achievement_icon_url"
}
```

## Firebase Functions

### tShirtPickUp

Request t-shirt pickup eligibility.

**Request:**

```json
{
  "points": 500 // minimum points required
}
```

**Response:**

```json
{
  "success": true,
  "eligible": true,
  "pointsRequired": 500,
  "userPoints": 650,
  "message": "T-shirt pickup requested successfully"
}
```

### updateUserProfile

Update user profile information.

**Request:**

```json
{
  "displayName": "New Display Name",
  "preferences": {
    "language": "it",
    "notifications": true
  }
}
```

**Response:**

```json
{
  "success": true,
  "message": "Profile updated successfully"
}
```

## Features

### Implemented Functionality

- User profile management
- Points tracking and history
- T-shirt pickup eligibility system
- User statistics and achievements
- Dashboard data aggregation
- Profile photo management
- User preferences handling
- Real-time points updates

### Exported Functionality

- User profile use cases
- Points management use cases
- T-shirt pickup use cases
- User dashboard use cases
- User state management (Bloc)
- User-related widgets
- User data models

## Home Dashboard Features

### Dashboard Data

The home screen aggregates:

- User's current points total
- Active quest information
- Recent points earned
- Ranking position
- T-shirt eligibility status
- Quick actions (new quest, view ranking)

### Real-time Updates

- Points updates in real-time
- Quest status changes
- Ranking position updates
- Achievement notifications

## Dependencies

- `cloud_firestore` - Firestore database
- `cloud_functions` - Firebase Functions integration
- `flutter_bloc` - State management
- `auth` - Authentication integration
- `core` - Shared utilities
- `quests` - Quest integration

## Usage

```dart
import 'package:user/user.dart';

// Get user profile
final profileUseCase = GetIt.instance<GetUserProfileUseCase>();
final result = await profileUseCase(GetUserProfileParams(userId: 'user123'));
result.fold(
  (error) => print('Error: ${error.message}'),
  (profile) => print('User: ${profile.displayName}'),
);

// Request t-shirt pickup
final tshirtUseCase = GetIt.instance<RequestTShirtPickUpUseCase>();
final tshirtResult = await tshirtUseCase(NoParams());

// Monitor user state
BlocBuilder<UserBloc, UserState>(
  builder: (context, state) {
    if (state is UserLoaded) {
      return UserProfileWidget(user: state.user);
    } else if (state is UserLoading) {
      return LoadingWidget();
    }
    return ErrorWidget();
  },
)

// Monitor points
BlocBuilder<PointsBloc, PointsState>(
  builder: (context, state) {
    if (state is PointsLoaded) {
      return PointsDisplayWidget(
        totalPoints: state.totalPoints,
        pointsBreakdown: state.pointsBreakdown,
      );
    }
    return LoadingWidget();
  },
)
```
