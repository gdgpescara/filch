import 'package:catch_and_flow/catch_and_flow.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionError extends CustomError {
  FirebaseFunctionError(FirebaseFunctionsException e)
    : super(code: e.code, message: e.message ?? 'An error occurred with Firebase Function');
}

class NotFoundError extends CustomError {
  NotFoundError() : super(code: 'not_found', message: 'The requested resource was not found');
}
