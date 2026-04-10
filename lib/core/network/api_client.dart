import 'package:dio/dio.dart';

import 'app_interceptor.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: "https://dummyjson.com/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(AppInterceptor());
  }
}