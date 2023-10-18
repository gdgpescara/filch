import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLoggedUserHouseUseCase {
  GetLoggedUserHouseUseCase(this._auth);

  final FirebaseAuth _auth;

  Future<String> call() async {
    final idToken = await _auth.currentUser!.getIdTokenResult(true);
    return idToken.claims?['house'] as String;
  }
}
