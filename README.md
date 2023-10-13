# filch

DevFest Pescara 2023 app.

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
select `devfestpescara-2023` then contnue to generate `firebase_options.dart`.


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
## Secrets tath you need

### Android
- .keystore
- secrets.properties

### iOS
- Secrets.xcconfig
