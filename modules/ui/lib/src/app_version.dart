import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../ui.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  final _shorebirdCodePush = GetIt.I<ShorebirdCodePush>();
  late String _version;
  bool _isNewPatchAvailableForDownload = false;
  bool _isNewPatchReadyToInstall = false;

  @override
  void initState() {
    super.initState();
    final packageInfo = GetIt.I<PackageInfo>();
    _shorebirdCodePush.currentPatchNumber().then((patch) {
      setState(() {
        if(patch != null) {
          _version = t.common.app_version.with_patch(version: packageInfo.version, patch: patch);
        } else {
          _version = t.common.app_version.without_patch(version: packageInfo.version);
        }
      });
    });
    _version = packageInfo.version;
    _shorebirdCodePush.isNewPatchAvailableForDownload().then((value) {
      _shorebirdCodePush.downloadUpdateIfAvailable().then((value) {
        _shorebirdCodePush.isNewPatchReadyToInstall().then((value) {
          setState(() {
            _isNewPatchReadyToInstall = value;
          });
        });
      });
      setState(() {
        _isNewPatchAvailableForDownload = value;
      });
    });
    _shorebirdCodePush.isNewPatchReadyToInstall().then((value) {
      setState(() {
        _isNewPatchReadyToInstall = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _version,
            style: context.getTextTheme().bodySmall,
          ),
        ),
        if (_isNewPatchAvailableForDownload)
          Expanded(
            child: Text(
              t.common.app_version.new_patch_available_to_download,
              style: context.getTextTheme().bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        if (_isNewPatchReadyToInstall)
          Expanded(
            child: Text(
              t.common.app_version.new_patch_ready_to_install,
              style: context.getTextTheme().bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
