import 'package:flutter/foundation.dart';

/// 간단한 로거 유틸리티
class Logger {
  static void d(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[DEBUG] $message');
    if (error != null) {
      debugPrint('[ERROR] $error');
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message');
    if (error != null) {
      debugPrint('[ERROR] $error');
      if (stackTrace != null) {
        debugPrint('[STACK] $stackTrace');
      }
    }
  }

  static void i(String message) {
    debugPrint('[INFO] $message');
  }

  static void w(String message) {
    debugPrint('[WARN] $message');
  }
}
