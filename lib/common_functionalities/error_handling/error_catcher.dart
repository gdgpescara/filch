import 'package:loggy/loggy.dart';

import 'failure.dart';

//ignore: avoid_annotating_with_dynamic
typedef FailureFromExceptionFunction = Failure Function(dynamic e);
typedef FutureOperationFunction<T> = Future<T> Function();
typedef StreamOperationFunction<T> = Stream<T> Function();

Future<T> runSafetyFuture<T>(
  FutureOperationFunction<T> operation, {
  FailureFromExceptionFunction? onException,
}) async {
  try {
    return await operation();
  } catch (e) {
    logError(e);
    if (e is Failure) return Future.error(e);
    return Future.error(onException?.call(e) ?? Failure.genericFromException(e));
  }
}

Future<T?> runSafetyFutureNullable<T>(
  FutureOperationFunction<T?> operation, {
  FailureFromExceptionFunction? onException,
}) async {
  try {
    return await operation();
  } catch (e) {
    logError(e);
    return null;
  }
}

Stream<T> runSafetyStream<T>(
  StreamOperationFunction<T> operation, {
  FailureFromExceptionFunction? onException,
}) {
  // ignore: inference_failure_on_untyped_parameter
  return operation().handleError((e) {
    logError(e);
    if (e is Failure) throw e;
    throw onException?.call(e) ?? Failure.genericFromException(e);
  });
}

T? runSafetySync<T>(
  T Function() operation, {
  FailureFromExceptionFunction? onException,
}) {
  try {
    return operation();
  } catch (e) {
    logError(e);
    return null;
  }
}

Function onErrorHandler(void Function(Failure)? failure) => (dynamic e) {
      logError(e);
      if (e is Failure) {
        failure?.call(e);
      } else {
        failure?.call(Failure.genericFromException(e));
      }
    };
