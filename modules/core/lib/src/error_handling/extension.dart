import 'dart:async';

import 'package:flutter/material.dart';

import 'error_catcher.dart';
import 'failure.dart';

typedef SuccessCallback<T> =  void Function(T);
typedef FailureCallback = void Function(Failure);

extension FutureExtension<T> on Future<T> {
  Future<void> when({
    VoidCallback? progress,
    SuccessCallback<T>? success,
    FailureCallback? failure,
  }) async {
    progress?.call();
    await then((value) => success?.call(value)).catchError(onErrorHandler(failure));
  }
}

extension StreamExtension<T> on Stream<T> {
  StreamSubscription<T> when({
    VoidCallback? progress,
    SuccessCallback<T>? success,
    FailureCallback? failure,
  }) {
    progress?.call();
    handleError(onErrorHandler(failure)).forEach((value) => success?.call(value));
    return listen(null);
  }
}
