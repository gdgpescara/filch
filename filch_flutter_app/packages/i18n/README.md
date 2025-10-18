# I18n Package

Internationalization package providing localization support for English and Italian languages using the slang code generation library.

## Supported Languages

- **English (en)** - Primary language
- **Italian (it)** - Secondary language

## Features

### Implemented Functionality

- Multi-language support (English/Italian)
- Type-safe translation keys
- Code generation for translations
- Plural forms support
- Parameter interpolation
- Namespace organization
- Hot reload support for translations

### Translation Structure

Translations are organized in namespaces:

```dart
// Common translations
t.common.ok
t.common.cancel
t.common.save
t.common.delete
t.common.loading

// Authentication
t.auth.signIn
t.auth.signOut
t.auth.forgotPassword
t.auth.createAccount

// Quests
t.quests.title
t.quests.description
t.quests.start
t.quests.complete
t.quests.timeRemaining

// Points & Ranking
t.points.total
t.points.earned
t.ranking.position
t.ranking.leaderboard

// Errors
t.errors.networkError
t.errors.unknownError
t.errors.validationError
```

## Code Generation

### slang Configuration

The package uses slang for code generation with the following configuration:

```yaml
# slang.yaml
base_locale: en
input_directory: assets/i18n
output_directory: lib/src/generated
```

### Translation Files

Translation files are stored in `assets/i18n/`:

- `strings.i18n.json` - Base English translations
- `strings_it.i18n.json` - Italian translations

### Generation Command

```bash
dart run slang
```

## Usage Examples

### Basic Translations

```dart
import 'package:i18n/i18n.dart';

// Simple translation
Text(t.common.ok)

// With parameters
Text(t.quests.pointsEarned(points: 100))

// Plural forms
Text(t.quests.questsRemaining(count: questCount))
```

### Context Extensions

```dart
// Using context extension
Text(context.t.auth.signIn)

// In widgets
AppBar(
  title: Text(context.t.quests.title),
)
```

### Dynamic Language Switching

```dart
// Change language
LocaleSettings.setLocale(AppLocale.it);

// Get current locale
final currentLocale = LocaleSettings.currentLocale;
```

## Translation Keys Structure

### Common Keys

```json
{
  "common": {
    "ok": "OK",
    "cancel": "Cancel", 
    "save": "Save",
    "delete": "Delete",
    "loading": "Loading...",
    "error": "Error",
    "retry": "Retry",
    "continue": "Continue",
    "back": "Back",
    "next": "Next",
    "previous": "Previous",
    "done": "Done",
    "close": "Close"
  }
}
```

### Authentication Keys

```json
{
  "auth": {
    "signIn": "Sign In",
    "signOut": "Sign Out", 
    "signUp": "Sign Up",
    "email": "Email",
    "password": "Password",
    "forgotPassword": "Forgot Password?",
    "createAccount": "Create Account",
    "welcomeBack": "Welcome Back",
    "signInWith": "Sign in with {provider}",
    "accountCreated": "Account created successfully"
  }
}
```

### Quest Keys

```json
{
  "quests": {
    "title": "Quests",
    "description": "Description",
    "start": "Start Quest",
    "complete": "Complete Quest",
    "giveUp": "Give Up",
    "timeRemaining": "Time remaining: {time}",
    "pointsEarned": "You earned {points} points!",
    "questCompleted": "Quest Completed!",
    "noActiveQuest": "No active quest",
    "searchingQuest": "Searching for quest...",
    "questNotFound": "No quest available",
    "questTypes": {
      "actor": "Actor Quest",
      "quiz": "Quiz Quest", 
      "social": "Social Quest",
      "community": "Community Quest"
    }
  }
}
```

### Points & Ranking Keys

```json
{
  "points": {
    "total": "Total Points",
    "earned": "Points Earned",
    "breakdown": "Points Breakdown",
    "questPoints": "Quest Points",
    "staffPoints": "Staff Points",
    "communityPoints": "Community Points"
  },
  "ranking": {
    "title": "Ranking",
    "position": "Position #{position}",
    "leaderboard": "Leaderboard",
    "yourPosition": "Your Position",
    "topUsers": "Top Users",
    "points": "{points} pts"
  }
}
```

### Error Keys

```json
{
  "errors": {
    "networkError": "Network connection error",
    "serverError": "Server error occurred",
    "unknownError": "An unknown error occurred",
    "validationError": "Please check your input",
    "authError": "Authentication failed",
    "questError": "Quest operation failed",
    "permissionDenied": "Permission denied"
  }
}
```

## Exported Functionality

- Generated translation classes
- Locale management utilities
- Translation functions
- Language switching functionality
- Pluralization support
- Parameter interpolation

## Dependencies

- `slang` - Code generation for translations
- `flutter_localizations` - Flutter localization support

## Setup

### 1. Configure slang

Create `slang.yaml` in the package root:

```yaml
base_locale: en
input_directory: assets/i18n
output_directory: lib/src/generated
string_interpolation: double_braces
```

### 2. Add Translation Files

Create translation files in `assets/i18n/`:

- `strings.i18n.json` - English translations
- `strings_it.i18n.json` - Italian translations

### 3. Generate Code

```bash
dart run slang
```

### 4. Initialize in App

```dart
import 'package:i18n/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale(); // Use device locale
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: AppLocaleUtils.supportedLocales,
      home: HomePage(),
    );
  }
}
```

## Best Practices

### Key Naming

- Use descriptive, hierarchical keys
- Group related translations
- Use camelCase for consistency
- Avoid deep nesting (max 3 levels)

### Parameter Usage

```dart
// Good
t.welcome.message(userName: user.name)

// Avoid hardcoded text
"Hello, ${user.name}!"
```

### Pluralization

```dart
// Define plural forms
"items(n)": {
  "zero": "No items",
  "one": "1 item", 
  "other": "{n} items"
}

// Usage
t.items(n: itemCount)
```

### Language Detection

```dart
// Automatic device locale
LocaleSettings.useDeviceLocale();

// Manual locale setting
LocaleSettings.setLocale(AppLocale.it);

// Persistent locale storage
LocaleSettings.setLocale(
  await getStoredLocale() ?? AppLocale.en
);
```
