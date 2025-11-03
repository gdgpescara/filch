# Contributing to Filch

Thank you for your interest in contributing to Filch! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Commit Message Guidelines](#commit-message-guidelines)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/filch.git`
3. Add upstream remote: `git remote add upstream https://github.com/gdgpescara/filch.git`
4. Create a new branch: `git checkout -b feature/your-feature-name`

## Project Structure

This is a multi-package monorepo containing:

- **`/filch_flutter_app`** - Flutter mobile application (managed with Melos)
  - `/packages/app` - Main application
  - `/packages/auth` - Authentication module
  - `/packages/core` - Core utilities
  - `/packages/ui` - UI components
  - `/packages/i18n` - Internationalization
  - `/packages/quests` - Quests feature
  - `/packages/schedule` - Schedule feature
  - Other feature packages
  
- **`/functions`** - Python Cloud Functions for Firebase
  
- **`/node-functions`** - TypeScript/Node.js Cloud Functions for Firebase
  
- **`/firebase_command_line_scripts`** - Firebase admin scripts and utilities

## Development Setup

### Prerequisites

- **Flutter**: Install Flutter SDK (stable channel recommended)
- **FVM**: Flutter Version Management (optional but recommended)
- **Node.js**: v18 or higher
- **Python**: 3.11 or higher
- **Firebase CLI**: `npm install -g firebase-tools`
- **Melos**: `dart pub global activate melos`

### Flutter Application Setup

```bash
cd filch_flutter_app

# If using FVM
fvm use stable
fvm flutter pub get

# Or without FVM
flutter pub get

# Bootstrap all packages with Melos
melos bootstrap

# Run code generation
melos run build_runner
```

### Python Functions Setup

```bash
cd functions

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
# venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Node.js Functions Setup

```bash
cd node-functions

# Install dependencies
npm install

# Build TypeScript
npm run build
```

### Firebase Setup

1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Set up your Firebase project (development environment)
4. Copy environment configuration files (see each package's README)

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/gdgpescara/filch/issues)
2. If not, create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots (if applicable)
   - Environment details (OS, Flutter version, etc.)

### Suggesting Enhancements

1. Check existing [Issues](https://github.com/gdgpescara/filch/issues) for similar suggestions
2. Create a new issue with:
   - Clear description of the enhancement
   - Use cases and benefits
   - Possible implementation approach (if you have ideas)

### Contributing Code

1. Pick an issue or create one for discussion
2. Comment on the issue to let others know you're working on it
3. Follow the development workflow below

## Coding Standards

### Flutter/Dart

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check for issues
- Format code with `dart format .`
- Run linter: `flutter analyze`
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Follow the existing project structure

**Example:**

```dart
/// Fetches user data from Firestore.
///
/// Returns a [User] object if found, null otherwise.
/// Throws [FirebaseException] if the operation fails.
Future<User?> fetchUser(String userId) async {
  // Implementation
}
```

### Python

- Follow [PEP 8](https://pep8.org/) style guide
- Use type hints for function signatures
- Use docstrings for functions and classes
- Maximum line length: 88 characters (Black formatter)
- Use meaningful variable and function names

**Example:**

```python
def assign_points(user_id: str, points: int, reason: str) -> dict:
    """
    Assigns points to a user.

    Args:
        user_id: The unique identifier of the user
        points: Number of points to assign
        reason: Reason for point assignment

    Returns:
        Dictionary with updated user points data

    Raises:
        ValueError: If points is negative
        FirebaseError: If database operation fails
    """
    # Implementation
```

### TypeScript/Node.js

- Follow [TypeScript ESLint](https://typescript-eslint.io/) recommended rules
- Use meaningful variable and function names
- Add JSDoc comments for public functions
- Prefer `const` over `let`, avoid `var`
- Use async/await over raw Promises

**Example:**

```typescript
/**
 * Updates quest status for a user
 * @param userId - The user's unique identifier
 * @param questId - The quest identifier
 * @returns Updated quest data
 */
export async function updateQuestStatus(
  userId: string,
  questId: string
): Promise<QuestData> {
  // Implementation
}
```

### General Principles

- **DRY** (Don't Repeat Yourself) - Extract common logic
- **SOLID** principles - Especially Single Responsibility
- **Error Handling** - Always handle errors gracefully
- **Security** - Follow guidelines in [SECURITY.md](./SECURITY.md)
- **Performance** - Consider performance implications
- **Accessibility** - Ensure UI is accessible

## Testing

### Flutter Tests

```bash
cd filch_flutter_app

# Run all tests
melos run test

# Run tests for specific package
cd packages/auth
flutter test

# Run with coverage
flutter test --coverage
```

### Python Tests

```bash
cd functions

# Run tests (if test framework is set up)
pytest

# Run with coverage
pytest --cov=features
```

### Node.js Tests

```bash
cd node-functions

# Run tests
npm test

# Run with coverage
npm run test:coverage
```

### Test Requirements

- Add unit tests for new features
- Maintain or improve code coverage
- Test edge cases and error scenarios
- Mock external dependencies (Firebase, APIs)

## Pull Request Process

1. **Update Your Branch**

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Ensure Quality**
   - [ ] Code follows style guidelines
   - [ ] All tests pass
   - [ ] No linting errors
   - [ ] Documentation is updated
   - [ ] CHANGELOG.md is updated (if applicable)

3. **Create Pull Request**
   - Use a clear, descriptive title
   - Reference related issues (e.g., "Fixes #123")
   - Describe what changed and why
   - Include screenshots for UI changes
   - List any breaking changes

4. **Code Review**
   - Address reviewer feedback promptly
   - Keep discussions professional and constructive
   - Make requested changes in new commits
   - Once approved, maintainers will merge

5. **After Merge**
   - Delete your feature branch
   - Update your local main branch

## Commit Message Guidelines

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, no logic change)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks, dependency updates

### Examples

```
feat(auth): add biometric authentication support

Implements fingerprint and face ID authentication for iOS and Android.
Uses local_auth package for biometric verification.

Closes #45
```

```
fix(quests): prevent duplicate quest submissions

Add validation to check if user has already submitted an answer
before allowing new submissions.

Fixes #78
```

```
docs(readme): update setup instructions for M1 Macs

Add specific instructions for Apple Silicon compatibility issues
with CocoaPods and Rosetta.
```

## Package-Specific Guidelines

### Flutter Packages

- Each package should have its own README.md
- Export public APIs through a single barrel file
- Keep packages focused and cohesive
- Update pubspec.yaml version following semver

### Python Functions

- Each feature should be in its own module
- Use type hints consistently
- Handle Firebase errors appropriately
- Log important operations for debugging

### Node.js Functions

- Organize by feature in `/src/features`
- Use proper TypeScript types (avoid `any`)
- Implement proper error handling
- Test functions locally with Firebase emulators

## Environment Configuration

Never commit:

- API keys or secrets
- Service account credentials
- `.env` files with sensitive data
- Firebase configuration files with real project IDs

Use:

- Environment variables for sensitive config
- `.env.example` files to show required variables
- Separate Firebase projects for dev/staging/prod

## Questions or Need Help?

- Check existing [Issues](https://github.com/gdgpescara/filch/issues) and [Discussions](https://github.com/gdgpescara/filch/discussions)
- Create a new discussion for questions
- Reach out to maintainers if needed

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](./filch_flutter_app/LICENSE)).

---

Thank you for contributing to Filch! 🎉

