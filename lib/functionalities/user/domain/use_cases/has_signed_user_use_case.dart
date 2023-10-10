import 'package:injectable/injectable.dart';

import '../repositories/user_repository.dart';

@lazySingleton
class HasSignedUserUseCase {
  HasSignedUserUseCase(this._userRepository);
  final UserRepository _userRepository;

  bool call() {
    return _userRepository.hasSignedUser();
  }
}
