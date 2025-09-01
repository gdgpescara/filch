# Filch

DevFest Pescara app - A modular Flutter app for event and quest management.

## Project Structure

Filch is organized as a melos workspace with modular architecture. Here's the main structure:

### Flutter App (packages/)

The Flutter project is divided into several modular packages:

- **`packages/app/`** - Main Flutter app that integrates all modules
- **`packages/core/`** - Shared core functionality (utilities, configurations)
- **`packages/auth/`** - Firebase authentication management
- **`packages/ui/`** - Reusable UI components and theme
- **`packages/i18n/`** - Internationalization management
- **`packages/quests/`** - Quest and challenges system
- **`packages/user/`** - User profile management
- **`packages/staff/`** - Staff functionality
- **`packages/schedule/`** - Event schedule management
- **`packages/sorting_ceremony/`** - Sorting ceremony
- **`packages/media_manager/`** - Media and image management
- **`packages/assets/`** - Shared assets

### Backend Services

- **`functions/`** - Python Firebase Functions for server-side logic
- **`node-functions/`** - Node.js TypeScript Firebase Functions
- **`firebase_command_line_scripts/`** - Scripts for Firestore data management

### Configuration

- **`firebase.json`** - Firebase configuration
- **`firestore.rules`** - Firestore security rules
- **`firestore.indexes.json`** - Firestore indexes
- **`pubspec.yaml`** - Melos workspace configuration

## Development Environment Setup

### Prerequisites

1. **Flutter SDK** (version >=3.32.5)
2. **Dart SDK** (version ^3.8.1)
3. **Node.js** (version 20+) for Firebase Functions
4. **Python** (version 3.12+) for Python Firebase Functions
5. **Firebase CLI**
6. **Git**

### Initial Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd filch
```

### 2. Install Flutter Dependencies

Install melos to manage the workspace:

```bash
dart pub global activate melos
```

Bootstrap the workspace (install dependencies for all packages):

```bash
melos bootstrap
```

### 3. Install Firebase CLI

```bash
npm install -g firebase-tools
```

### 4. Login to Firebase CLI

```bash
firebase login
```

### 5. Activate Flutterfire

```bash
dart pub global activate flutterfire_cli
```

### 6. Configure Firebase Project

```bash
flutterfire configure
```

Select your Firebase project and continue to generate `firebase_options.dart`.

### 7. Install Dependencies for Firebase Functions

#### For Node.js Functions

```bash
cd node-functions
npm install
cd ..
```

#### For Python Functions

```bash
cd functions
pip install -r requirements.txt
cd ..
```

### 8. Setup Firebase Command Line Scripts

```bash
cd firebase_command_line_scripts
npm install
cd ..
```

### 9. Configure Secret Files

Create the following configuration files (see "Required Secret Files" section):

- `.env` (for Flutter)
- `.keystore` and `secrets.properties` (for Android)
- `Secrets.xcconfig` (for iOS)
- Service Account Key for Firebase Admin SDK

## Development Commands

### Code Generation

Generate all necessary code (localizations, models, etc.):

```bash
melos run generate
```

### Localized Strings Generation

```bash
dart run slang
```

### Start Firebase Emulators

For local development with emulators:

```bash
cd node-functions
npm run serve
```

### Build and Deploy

#### Build Flutter App

```bash
cd packages/app
flutter build apk  # For Android
flutter build ios  # For iOS
```

#### Deploy Firebase Functions

```bash
cd node-functions
npm run deploy
```

### Testing

Run tests for all packages:

```bash
melos run test
```

## Local Development

### Recommended Development Structure

1. **Main app**: Work primarily in `packages/app/`
2. **New features**: Create business logic in specific packages
3. **UI Components**: Add reusable components in `packages/ui/`
4. **API calls**: Use `packages/core/` for shared services

### Hot Reload

Thanks to the modular structure, you can develop with hot reload active:

```bash
cd packages/app
flutter run
```

### Debugging Firebase Functions

For local debugging of functions:

```bash
cd node-functions
npm run serve
```

This will start Firebase emulators for local testing.

## Required Secret Files

### Flutter

- `.env` - Environment variables file

### Android

- `.keystore` - Keystore for APK signing
- `secrets.properties` - Secret properties for Android build

### iOS

- `Secrets.xcconfig` - Secret configuration file for iOS

### Firebase Functions

Filch app uses Firebase Functions for server-side logic. To deploy functions you need:

- A Firebase project
- Service Account Key for Firebase Admin SDK
- Functions are located in `functions` folder (Python) and `node-functions` folder (TypeScript)

### Firestore Data Management

To manage Firestore data there's a project called `firebase_command_line_scripts` used to seed data into Firestore.

This project provides a set of scripts to manage Firestore data. Read the README.md in the project to learn how to use it.

### Service Account Configuration

1. Go to Firebase Console
2. Go to Project Settings > Service accounts
3. Generate a new private key
4. Save the JSON file as `serviceAccountKey.json` in `firebase_command_line_scripts/`

## Troubleshooting

### Common Errors

1. **"Flutter SDK not found"**: Make sure Flutter is in PATH
2. **"Firebase project not configured"**: Run `flutterfire configure`
3. **"Melos command not found"**: Run `dart pub global activate melos`
4. **Build errors**: Make sure all secrets are configured correctly

### Complete Reset

If you have issues, you can do a complete reset:

```bash
melos clean
melos bootstrap
```

## Contributing

1. Create a branch for your feature
2. Follow the project's code conventions
3. Add tests if necessary
4. Create a pull request

---

For specific questions about individual modules, check the README.md files in the respective package folders.

### Seeding and managing Firestore data
To manage Firestore data there is a project called `firebase_command_line_scripts` that is used to seed data into Firestore.
This project provide a set of scripts to manage Firestore data.
read the README.md in the project to know how to use it.

### Endpoint testati
Questi endpoint sono stati testati nell'emulatore locale.

- scan_other_attendee (Utilizzato Request con dati mockati e non Callable) -> Da testare deployato
- submit_answer (Utilizzato Request con dati mockati e non Callable) -> Da testare deployato
- user_points_sentinel (Modificato record direttamente da firestore e verificata la modifica)