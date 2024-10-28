# filch

DevFest Pescara app.

## Getting Started

### 1. Install Firebase CLI

```bash
npm install -g firebase-tools
```

### 2. Login into Firebase CLI
    
```bash
firebase login
```

### 3. Activate Flutterfire

```bash
dart pub global activate flutterfire_cli
```
### 4. Configure Firebase project
    
```bash
flutterfire configure
```
select `project` then contnue to generate `firebase_options.dart`.


## How to start development

You can run commands by hand or you can use melos commands.

To use melos you need to activate it:

```bash
dart pub global activate melos
```

To generate code you can use melos commands:

```bash
melos run generate
```

### Generate locale string
    
```bash
dart run slang
```
## Secrets that you need

### Flutter
- .env 

### Android
- .keystore
- secrets.properties

### iOS
- Secrets.xcconfig


### Firebase Functions
Filch app uses Firebase Functions to do some server-side logic. To deploy functions you need to have a Firebase project and a Firebase Functions project.
The functions are located in `functions` folder.

### Seeding and managing Firestore data
To manage Firestore data there is a project called `firebase_command_line_scripts` that is used to seed data into Firestore.
This project provide a set of scripts to manage Firestore data.
read the README.md in the project to know how to use it.