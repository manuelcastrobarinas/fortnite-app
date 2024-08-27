import 'package:dio/dio.dart';

class LanguageIterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'lang':'es'
    });
    super.onRequest(options, handler);
  }
}