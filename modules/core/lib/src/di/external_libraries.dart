import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ExternalLibraries {
  @preResolve
  Future<PackageInfo> packageInfo() => PackageInfo.fromPlatform();
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();
}
