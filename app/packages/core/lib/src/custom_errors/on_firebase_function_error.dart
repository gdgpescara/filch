import 'package:cloud_functions/cloud_functions.dart';

import '../../core.dart';

dynamic onFirebaseFunctionError(dynamic e) {
  if (e is FirebaseFunctionsException) {
    return FirebaseFunctionError(e);
  }
  return e;
}
