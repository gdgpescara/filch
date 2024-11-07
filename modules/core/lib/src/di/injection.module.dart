//@GeneratedMicroModule;CorePackageModule;package:core/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;
import 'dart:io' as _i497;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:core/src/di/date_format_module.dart' as _i1016;
import 'package:core/src/di/external_libraries.dart' as _i545;
import 'package:core/src/use_cases/get_feature_flags_use_case.dart' as _i866;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:intl/intl.dart' as _i602;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:shorebird_code_push/shorebird_code_push.dart' as _i624;

class CorePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final externalLibraries = _$ExternalLibraries();
    final dateFormatModule = _$DateFormatModule();
    await gh.factoryAsync<_i655.PackageInfo>(
      () => externalLibraries.packageInfo(),
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => externalLibraries.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i809.FirebaseFunctions>(
        () => externalLibraries.firebaseFunctions);
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => externalLibraries.firestore);
    gh.lazySingleton<_i892.FirebaseMessaging>(
        () => externalLibraries.firebaseMessaging);
    gh.lazySingleton<_i457.Reference>(() => externalLibraries.storageRef);
    gh.lazySingleton<_i183.ImagePicker>(() => externalLibraries.imagePicker);
    gh.lazySingleton<_i624.ShorebirdCodePush>(
        () => externalLibraries.shorebirdCodePush);
    await gh.factoryAsync<_i497.Directory>(
      () => externalLibraries.documentDirectory(),
      instanceName: 'documentDirectory',
      preResolve: true,
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatTime,
      instanceName: 'onlyTime',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatFull,
      instanceName: 'full',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatYear,
      instanceName: 'year',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatHour,
      instanceName: 'hour',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatAmPm,
      instanceName: 'amPm',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatMonth,
      instanceName: 'month',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatWeekDay,
      instanceName: 'weekDay',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatDay,
      instanceName: 'day',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatMinute,
      instanceName: 'minute',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatDate,
      instanceName: 'onlyDate',
    );
    gh.lazySingleton<_i602.DateFormat>(
      () => dateFormatModule.dateFormatFullReadable,
      instanceName: 'fullReadable',
    );
    gh.lazySingleton<_i866.GetFeatureFlagsUseCase>(
        () => _i866.GetFeatureFlagsUseCase(gh<_i974.FirebaseFirestore>()));
  }
}

class _$ExternalLibraries extends _i545.ExternalLibraries {}

class _$DateFormatModule extends _i1016.DateFormatModule {}
