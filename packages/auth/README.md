# Auth Package

Authentication package providing Firebase Authentication integration with different authentication providers.

## Data Models

### ProvidersEnum

Supported authentication providers:

- `google` - Google Sign-In
- `apple` - Apple Sign-In
- `emailPassword` - Email/Password authentication

### Custom Errors

#### FirebaseAuthError

Wraps Firebase Authentication exceptions into custom error format.

```dart
class FirebaseAuthError extends CustomError {
  FirebaseAuthError(FirebaseAuthException e);
}
```

#### UserUnauthenticatedError

Error thrown when user is not authenticated.

```dart
class UserUnauthenticatedError extends CustomError {
  UserUnauthenticatedError();
}
```

## Use Cases

### Authentication Management

- **SignInUseCase** - Sign in with different providers
- **SignOutUseCase** - Sign out current user
- **GetCurrentUserUseCase** - Get current authenticated user
- **CheckAuthStateUseCase** - Monitor authentication state changes

### User Profile Management

- **UpdateUserProfileUseCase** - Update user display name and photo
- **DeleteUserUseCase** - Delete user account
- **LinkAccountUseCase** - Link multiple authentication providers

## State Management

### AuthBloc

Manages authentication state throughout the application.

#### States

- **AuthInitial** - Initial state
- **AuthAuthenticated** - User is signed in
- **AuthUnauthenticated** - User is signed out
- **AuthLoading** - Authentication in progress
- **AuthError** - Authentication error occurred

#### Events

- **AuthSignInRequested** - Request sign in with provider
- **AuthSignOutRequested** - Request sign out
- **AuthCheckRequested** - Check current auth state
- **AuthUserUpdated** - User profile updated

## Widgets

### SignInButton

Pre-built authentication button supporting multiple providers.

```dart
SignInButton(
  provider: ProvidersEnum.google,
  onPressed: () => context.read<AuthBloc>().add(AuthSignInRequested(ProvidersEnum.google)),
)
```

### AuthStateWidget

Widget that builds different UI based on authentication state.

```dart
AuthStateWidget(
  authenticated: (user) => DashboardScreen(),
  unauthenticated: () => SignInScreen(),
  loading: () => LoadingWidget(),
)
```

## Firebase Functions Integration

### Request/Response Models

#### SignInRequest

```dart
{
  "provider": "google|apple|emailPassword",
  "email": "user@example.com", // for email/password
  "password": "password", // for email/password
  "idToken": "token" // for Google/Apple
}
```

#### SignInResponse

```dart
{
  "success": true,
  "user": {
    "uid": "user_id",
    "email": "user@example.com",
    "displayName": "User Name",
    "photoURL": "photo_url"
  }
}
```

## Features

### Implemented Functionality

- Multi-provider authentication (Google, Apple, Email/Password)
- Authentication state management
- User profile management
- Error handling and custom exceptions
- Reactive authentication state monitoring
- Sign-in/sign-out flows

### Exported Functionality

- Authentication use cases
- Authentication state management (Bloc)
- Authentication widgets
- Custom error classes
- Provider enums

## Firebase Collections

### users

User document structure:

```dart
{
  "uid": "firebase_user_id",
  "email": "user@example.com",
  "displayName": "User Display Name",
  "photoURL": "profile_photo_url",
  "provider": "google|apple|email",
  "createdAt": Timestamp,
  "lastSignIn": Timestamp,
  "isEmailVerified": boolean
}
```

## Usage

```dart
import 'package:auth/auth.dart';

// Sign in with Google
context.read<AuthBloc>().add(
  AuthSignInRequested(ProvidersEnum.google)
);

// Monitor auth state
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) {
      // Navigate to dashboard
    } else if (state is AuthUnauthenticated) {
      // Navigate to sign in
    }
  },
  child: MyApp(),
)

// Check if user is authenticated
final authUseCase = GetIt.instance<GetCurrentUserUseCase>();
final result = await authUseCase(NoParams());
result.fold(
  (error) => print('Error: ${error.message}'),
  (user) => print('User: ${user?.displayName}'),
);
```

## Dependencies

- `firebase_auth` - Firebase Authentication
- `google_sign_in` - Google Sign-In
- `sign_in_with_apple` - Apple Sign-In
- `flutter_bloc` - State management
- `core` - Shared utilities
