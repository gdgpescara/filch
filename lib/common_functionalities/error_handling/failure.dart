import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';

class Failure extends Error with EquatableMixin {
  Failure({this.code = 'no-code', required this.message});

  factory Failure.genericError() => Failure(code: 'generic-error', message: '');

  factory Failure.offline() => Failure(code: 'offline', message: '');

  factory Failure.genericFromException(dynamic e) => Failure(code: 'exception', message: '$e');
  final String code;
  final String message;

  @override
  List<Object?> get props => [code, message];
}

// Object not found.
class NotFoundFailure extends Failure {
  NotFoundFailure() : super(code: 'not-found', message: 'Object not found.');
}

class FirebaseFunctionsFailure extends Failure {
  FirebaseFunctionsFailure(FirebaseFunctionsException e)
      : super(code: e.code, message: 'message: ${e.message}, details: ${e.details}');
}
