import 'package:flutter/material.dart';

import 'error_catcher.dart';
import 'failure.dart';

extension StreamExtension<T> on Stream<T> {
  void actions({
    VoidCallback? progress,
    void Function(T)? success,
    void Function(Failure)? failure,
  }) {
    progress?.call();
    handleError(onErrorHandler(failure)).forEach((value) => success?.call(value));
  }
}
