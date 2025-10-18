import 'dart:io';

import 'package:path/path.dart' as p;

import '../../core.dart';

extension $File on File {
  String get sizeInMb => FileUnitOfMeasure.megabyte.convert(lengthSync()).toStringWholeNumber;

  String get extension => p.extension(path).replaceAll('.', '').toUpperCase();

  String get name => p.basename(path);

  String get fileInfo => '${sizeInMb}MB \u2022 $extension';

  File renameFile(String newFileName) {
    final lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    final newPath = '${path.substring(0, lastSeparator + 1)}$newFileName${p.extension(path)}';
    return renameSync(newPath);
  }
}
