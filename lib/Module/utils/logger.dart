import 'dart:developer';
import 'package:flutter/foundation.dart';

void logDebug(String message, {String name = 'App'}) {
  if (kDebugMode) {
    log(message, name: name);
  }
}

void printDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}
