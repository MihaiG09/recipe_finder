import 'package:dio/dio.dart';

import 'interceptors/logger_interceptor.dart';

abstract class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    initDioOptions();
  }

  initDioOptions() async {
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 180);
    dio.interceptors.clear();

    dio.interceptors.addAll([LoggerInterceptor()]);
  }
}
