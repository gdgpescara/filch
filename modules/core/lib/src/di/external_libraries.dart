import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalLibraries {
  @preResolve
  Future<PackageInfo> packageInfo() => PackageInfo.fromPlatform();
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
  @lazySingleton
  FirebaseFunctions get firebaseFunctions => FirebaseFunctions.instance;
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
