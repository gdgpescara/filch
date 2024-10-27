import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@lazySingleton
class MoveFileUseCase {
  Future<String> call({
    required String srcPath,
    required String destDir,
    String? fileName,
  }) async {
    final dir = Directory(destDir);
    final appStorageDir = !dir.existsSync() ? await dir.create() : dir;
    final srcFile = File(srcPath);
    final destPath = '${appStorageDir.path}/${fileName ?? basename(srcFile.path)}';
    await srcFile.copy(destPath);
    return destPath;
  }
}
