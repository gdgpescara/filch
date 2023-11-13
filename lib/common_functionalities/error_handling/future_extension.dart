import 'package:flutter/material.dart';

import 'error_catcher.dart';
import 'failure.dart';

extension FutureExtension<T> on Future<T> {
  Future<void> actions({
    VoidCallback? progress,
    void Function(T)? success,
    void Function(Failure)? failure,
  }) async {
    progress?.call();
    await then((value) => success?.call(value)).catchError(onErrorHandler(failure));
  }
}
