import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fortnite_app/core/errors/api_error_type.dart';
import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/network/http_client.dart';

/// Adapter HTTP real sobre dio.
///
/// [baseUrl] es obligatoria y viene del composition root ([EnvConfig]).
/// Este cliente no conoce hosts ni entornos. Los headers y query por
/// defecto (token, idioma) también se inyectan desde afuera.
class DioHttpClient implements HttpClient {
  DioHttpClient({
    required String baseUrl,
    Map<String, String> defaultHeaders = const {},
    Map<String, dynamic> defaultQueryParameters = const {},
    Dio? dio,
  })  : _defaultQueryParameters = defaultQueryParameters,
        _dio = dio ??
            _buildDio(
              baseUrl: baseUrl,
              defaultHeaders: defaultHeaders,
            );

  static Dio _buildDio({
    required String baseUrl,
    required Map<String, String> defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration sendTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
  }) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Accept': 'application/json',
          ...defaultHeaders,
        },
        contentType: 'application/json',
        // No lanzar por status: el status viaja en HttpResponse.
        validateStatus: (_) => true,
      ),
    );
  }

  final Dio _dio;
  final Map<String, dynamic> _defaultQueryParameters;

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _guard(() async {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: _query(queryParameters),
        options: Options(headers: headers),
      );
      return _toHttpResponse(response);
    });
  }

  @override
  Future<HttpResponse> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) =>
      _send('POST', path, body: body, headers: headers);

  @override
  Future<HttpResponse> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) =>
      _send('PUT', path, body: body, headers: headers);

  @override
  Future<HttpResponse> patch(
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) =>
      _send('PATCH', path, body: body, headers: headers);

  @override
  Future<HttpResponse> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) =>
      _send('DELETE', path, body: body, headers: headers);

  Map<String, dynamic> _query(Map<String, dynamic>? extra) {
    return {..._defaultQueryParameters, ...?extra};
  }

  Future<HttpResponse> _send(
    String method,
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) {
    return _guard(() async {
      final response = await _dio.request<dynamic>(
        path,
        data: body,
        queryParameters: _query(null),
        options: Options(method: method, headers: headers),
      );
      return _toHttpResponse(response);
    });
  }

  HttpResponse _toHttpResponse(Response<dynamic> response) {
    var data = response.data;
    if (data is String && data.contains('<!DOCTYPE html>')) {
      throw const NetworkException(ApiErrorType.htmlResponse);
    }
    if (data is String && data.isEmpty) data = null;
    return HttpResponse(statusCode: response.statusCode ?? 0, data: data);
  }

  Future<HttpResponse> _guard(Future<HttpResponse> Function() action) async {
    try {
      return await action();
    } on NetworkException {
      rethrow;
    } on DioException catch (exception) {
      throw _classify(exception);
    } on SocketException catch (exception) {
      throw NetworkException(ApiErrorType.socketError, exception.message);
    } on TimeoutException {
      throw const NetworkException(ApiErrorType.receiveTimeout);
    } on FormatException catch (exception) {
      throw NetworkException(ApiErrorType.formatError, exception.message);
    }
  }

  NetworkException _classify(DioException exception) {
    final inner = exception.error;
    if (inner is SocketException) {
      return NetworkException(ApiErrorType.socketError, inner.message);
    }
    if (inner is TimeoutException) {
      return const NetworkException(ApiErrorType.receiveTimeout);
    }
    if (inner is FormatException) {
      return NetworkException(ApiErrorType.formatError, inner.message);
    }

    return switch (exception.type) {
      DioExceptionType.connectionError =>
        NetworkException(ApiErrorType.connectionError, exception.message),
      DioExceptionType.connectionTimeout =>
        const NetworkException(ApiErrorType.connectionTimeout),
      DioExceptionType.sendTimeout =>
        const NetworkException(ApiErrorType.sendTimeout),
      DioExceptionType.receiveTimeout =>
        const NetworkException(ApiErrorType.receiveTimeout),
      DioExceptionType.cancel =>
        const NetworkException(ApiErrorType.cancelled),
      DioExceptionType.badCertificate => const NetworkException(
          ApiErrorType.connectionError,
          'Certificado inválido',
        ),
      DioExceptionType.badResponse =>
        NetworkException(ApiErrorType.invalidResponse, exception.message),
      _ => NetworkException(ApiErrorType.unknownError, exception.message),
    };
  }

  void close() => _dio.close();
}

/// Cliente de la API limitada v1 (noticias, armas, jugadores).
class LimitedApiClient extends DioHttpClient {
  LimitedApiClient({
    required super.baseUrl,
    super.defaultHeaders,
    super.defaultQueryParameters,
  });
}

/// Cliente de la API limitada v2 (tienda).
class ShopApiClient extends DioHttpClient {
  ShopApiClient({
    required super.baseUrl,
    super.defaultHeaders,
    super.defaultQueryParameters,
  });
}
