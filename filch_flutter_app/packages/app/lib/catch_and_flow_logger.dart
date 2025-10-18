import 'package:core/core.dart';
import 'package:loggy/loggy.dart' as loggy;

class CatchAndFlowLoggerLoggy implements CatchAndFlowLogger {
  CatchAndFlowLoggerLoggy();

  @override
  void logDebug(dynamic message) {
    loggy.logDebug(message);
  }

  @override
  void logError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    loggy.logError(message, error, stackTrace);
  }

  @override
  void logInfo(dynamic message) {
    loggy.logInfo(message);
  }

  @override
  void logWarning(dynamic message) {
    loggy.logWarning(message);
  }
}
