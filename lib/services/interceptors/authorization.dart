import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthorizationInterceptor extends Interceptor {
  final String _accessToken = dotenv.get('ACCESS_TOKEN_LIMITED_API');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {    
    options.headers.addAll({
      'Authorization': _accessToken
    });
    
    super.onRequest(options, handler);
  }
}