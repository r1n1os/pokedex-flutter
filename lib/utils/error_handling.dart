import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorHandling {
  static Future<String> handleErrorMessage(
      DioException? dioException, String? errorMessage, int? statusCode) async {
    if (errorMessage != null) {
      if (kDebugMode) {
        print("Error: $errorMessage");
      }
      return errorMessage;
    }
    if (dioException != null) {
      return dioException.message.toString();
    }
    return 'Something when wrong. Please try again';
  }
}
