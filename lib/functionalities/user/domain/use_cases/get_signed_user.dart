import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_repository.dart';

@lazySingleton
class GetSignedUserUseCase {
  GetSignedUserUseCase(this._userRepository);
  final UserRepository _userRepository;

  Future<User?> call() {
    return _userRepository.getSignedUser();
  }
}
