import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    print("REQUEST: ${options.uri}");
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    print("RESPONSE: ${response.statusCode}");
    return handler.next(response);
  }

  @override
  void onError(DioException e, handler) {
    print("ERROR: ${e.message}");
    return handler.next(e);
  }
}