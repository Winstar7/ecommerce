import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException e, handler) {
    return handler.next(e);
  }
}