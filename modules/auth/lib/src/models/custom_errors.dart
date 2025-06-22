import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthError extends CustomError {
  FirebaseAuthError(FirebaseAuthException e)
    : super(code: e.code, message: e.message ?? 'An error occurred with Firebase Auth');
}

class UserUnauthenticatedError extends CustomError {
  UserUnauthenticatedError() : super(code: 'unauthenticated', message: 'User is not authenticated');
}
