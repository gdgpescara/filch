import 'package:flutter/material.dart';

import 'error_catcher.dart';
import 'failure.dart';

extension FutureExtension<T> on Future<T> {
  void actions({
    VoidCallback? progress,
    void Function(T)? success,
    void Function(Failure)? failure,
  }) {
    progress?.call();
    then((value) => success?.call(value)).catchError(onErrorHandler(failure));
  }
}
