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
  final _shorebirdUpdater = GetIt.I<ShorebirdUpdater>();
  late String _version;
  bool _newVersionAvailable = false;
  bool _updateError = false;

  @override
  void initState() {
    super.initState();
    final packageInfo = GetIt.I<PackageInfo>();
    _shorebirdUpdater.readCurrentPatch().then((patch) {
      setState(() {
        if (patch != null) {
          _version = t.common.app_version.with_patch(version: packageInfo.version, patch: patch);
        } else {
          _version = t.common.app_version.without_patch(version: packageInfo.version);
        }
      });
    });
    _version = packageInfo.version;
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      _newVersionAvailable = false;
      _updateError = false;
    });

    final status = await _shorebirdUpdater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        setState(() {
          _newVersionAvailable = true;
        });
        await _shorebirdUpdater.update();
      } on UpdateException catch (_) {
        setState(() {
          _updateError = true;
        });
      } finally {
        setState(() {
          _newVersionAvailable = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(_version, style: context.getTextTheme().bodySmall)),
        if (_newVersionAvailable)
          Expanded(
            child: Text(
              t.common.app_version.new_patch_available_to_download,
              style: context.getTextTheme().bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        if (_updateError)
          Expanded(
            child: Text(
              t.common.app_version.update_error,
              style: context.getTextTheme().bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
