# Core Package

The core package provides shared functionality and base utilities used across all other packages in the Filch workspace.

## Data Models

### CustomError
Base error class for application-wide error handling.

```dart
class CustomError extends Equatable {
  final String code;
  final String message;
}
```

### FileUnitOfMeasure
Enum for file size measurements:
- `bytes`
- `kb` 
- `mb`
- `gb`

## JSON Converters

### TimestampDateTimeConverter
Converts Firestore Timestamp to DateTime and vice versa.

### IntDurationConverter  
Converts integer minutes to Duration objects and vice versa.

## Extensions

### StringExtensions
- `toCapitalized()` - Capitalizes first letter
- `isValidEmail()` - Email validation

### DateTimeExtensions  
- `timeAgo()` - Human readable time difference
- `isToday()` - Check if date is today

## Use Cases

### Base Classes
- `UseCase<Type, Params>` - Abstract base class for all use cases
- `NoParams` - Empty parameters class

## Dependency Injection

### Injection Module
- `CoreDI` - GetIt module for core dependencies

## Features

### Exported Functionality
- Error handling infrastructure
- JSON serialization utilities
- Date/time operations
- String manipulation utilities
- Dependency injection setup
- Base classes for business logic

### Dependencies
- `equatable` - Value equality
- `get_it` - Dependency injection
- `injectable` - Code generation for DI
- `json_annotation` - JSON serialization
- `cloud_firestore` - Firestore integration

## Usage

```dart
import 'package:core/core.dart';

// Use custom errors
throw CustomError(code: 'invalid_input', message: 'Invalid data provided');

// Use converters in models
@TimestampDateTimeConverter()
final DateTime createdAt;

// Use extensions
final email = 'user@example.com';
if (email.isValidEmail()) {
  // Valid email
}

// Use base use case
class GetDataUseCase extends UseCase<String, GetDataParams> {
  @override
  Future<Either<CustomError, String>> call(GetDataParams params) async {
    // Implementation
  }
}
```
