//@GeneratedMicroModule;CorePackageModule;package:core/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:core/src/di/date_format_module.dart' as _i7;
import 'package:core/src/di/external_libraries.dart' as _i6;
import 'package:injectable/injectable.dart' as _i1;
import 'package:intl/intl.dart' as _i5;
import 'package:package_info_plus/package_info_plus.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

class CorePackageModule extends _i1.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i2.FutureOr<void> init(_i1.GetItHelper gh) async {
    final externalLibraries = _$ExternalLibraries();
    final dateFormatModule = _$DateFormatModule();
    await gh.factoryAsync<_i3.PackageInfo>(
      () => externalLibraries.packageInfo(),
      preResolve: true,
    );
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => externalLibraries.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatTime,
      instanceName: 'onlyTime',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatFull,
      instanceName: 'full',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatYear,
      instanceName: 'year',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatHour,
      instanceName: 'hour',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatAmPm,
      instanceName: 'amPm',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatMonth,
      instanceName: 'month',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatWeekDay,
      instanceName: 'weekDay',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatDay,
      instanceName: 'day',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatMinute,
      instanceName: 'minute',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatDate,
      instanceName: 'onlyDate',
    );
    gh.lazySingleton<_i5.DateFormat>(
      () => dateFormatModule.dateFormatFullReadable,
      instanceName: 'fullReadable',
    );
  }
}

class _$ExternalLibraries extends _i6.ExternalLibraries {}

class _$DateFormatModule extends _i7.DateFormatModule {}
