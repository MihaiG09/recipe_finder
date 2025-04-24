import 'package:flutter/material.dart';

class Logger {
  static LogLevel _level = LogLevel.debug;

  static void init({LogLevel? logLevel}) {
    Logger._level = logLevel ?? LogLevel.debug;
  }

  static i({
    required String message,
    String? tag,
    String? status,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_level == LogLevel.info) {
      debugPrint(
        "[info] ${time ?? DateTime.now()} ${tag ?? ''} ${status ?? ''} $message ${time ?? ''} ${error ?? ''}",
      );
    }
  }

  static d({
    required String message,
    String? tag,
    String? status,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_level == LogLevel.info || _level == LogLevel.debug) {
      debugPrint(
        "[debug] ${time ?? DateTime.now()} ${tag ?? ''} ${status ?? ''} $message ${time ?? ''} ${error ?? ''}",
      );
    }
  }

  static void w({
    required String message,
    String? tag,
    String? status,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_level == LogLevel.info ||
        _level == LogLevel.debug ||
        _level == LogLevel.warning) {
      debugPrint(
        "[warning] ${time ?? DateTime.now()} ${tag ?? ''} ${status ?? ''} $message ${time ?? ''} ${error ?? ''}",
      );
    }
  }

  static void e({
    required String message,
    String? tag,
    String? status,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint(
      "[error] ${time ?? DateTime.now()} ${tag ?? ''} ${status ?? ''} $message ${time ?? ''} ${error ?? ''}",
    );
  }
}

enum LogLevel { error, warning, debug, info }
