import 'package:dio/dio.dart';
import 'package:recipe_finder/common/utils/logger.dart';

///Custom logging interceptor to debug API calls
class LoggerInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.d(
      tag: runtimeType.toString(),
      message:
          'onRequest: ${options.method}; '
          'path: ${options.path}; ',
    );
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.e(
      tag: runtimeType.toString(),
      message:
          "onError: ${err.requestOptions.method};\n"
          "path: ${err.requestOptions.path};\n"
          "Message: $err\n"
          "Data: ${err.response?.data}",
    );
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.d(
      tag: runtimeType.toString(),
      message:
          'onResponse: ${response.requestOptions.method}; '
          'path: ${response.requestOptions.path}; '
          'status: success.',
    );
    handler.next(response);
  }
}
