import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> getSignedUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<bool> hasHouse() {
    return Future.value(false);
  }

  @override
  bool hasSignedUser() {
    return _firebaseAuth.currentUser != null;
  }
}
