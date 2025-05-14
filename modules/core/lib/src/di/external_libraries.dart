import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

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

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @lazySingleton
  Reference get storageRef => FirebaseStorage.instance.ref();

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @preResolve
  @Named('documentDirectory')
  Future<Directory> documentDirectory() => getApplicationDocumentsDirectory();

  @lazySingleton
  ShorebirdUpdater get shorebirdUpdater => ShorebirdUpdater();
  
}
