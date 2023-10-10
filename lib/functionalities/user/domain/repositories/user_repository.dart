import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserRepository {
  Future<User?> getSignedUser();

  bool hasSignedUser();

  Future<bool> hasHouse();
}
