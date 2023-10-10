import 'package:injectable/injectable.dart';

import '../repositories/user_repository.dart';

@lazySingleton
class HasHouseUseCase {
  HasHouseUseCase(this._userRepository);
  final UserRepository _userRepository;

  Future<bool> call() {
    return _userRepository.hasHouse();
  }
}
