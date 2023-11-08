import 'package:dio/dio.dart';

class Urls {
  final String _baseUrl = '';

  Future<void> initializeDio() async {
    Dio().options.baseUrl = _baseUrl;
  }
}