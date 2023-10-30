import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsStaffUserUseCase {
  IsStaffUserUseCase(this._auth);

  final FirebaseAuth _auth;

  bool call() {
    return _auth.currentUser?.providerData.any((userInfo) => userInfo.providerId == 'password') ?? false;
  }
}
