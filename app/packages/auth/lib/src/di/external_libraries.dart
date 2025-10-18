import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ExternalLibraries {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @preResolve
  Future<GoogleSignIn> get googleSignIn async {
    final googleSignInInstance = GoogleSignIn.instance;
    await googleSignInInstance.initialize();
    return googleSignInInstance;
  }
}
