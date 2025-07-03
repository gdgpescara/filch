import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ExternalLibraries {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
