import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

final injector = GetIt.asNewInstance();

@InjectableInit()
Future<void> initAppInjectorModule() async {}

@module
abstract class ExternalPackages {
  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseFunctions get functions => FirebaseFunctions.instanceFor(region: 'europe-west3');

  @lazySingleton
  @Named('full')
  DateFormat get dateFormat => DateFormat('dd MMM yyyy • HH:mm');
}
