/// Contrato del cliente HTTP de la app.
///
/// Las features nunca importan `dio` ni ningún paquete de red directamente:
/// dependen de esta interfaz. El paquete concreto se cambia en un solo lugar.
abstract class HttpClient {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  Future<HttpResponse> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> patch(
    String path, {
    Object? body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> delete(
    String path, {
    Object? body,
    Map<String, String>? headers,
  });
}

/// Respuesta HTTP neutra, independiente del paquete de red usado.
class HttpResponse {
  const HttpResponse({required this.statusCode, this.data});

  final int statusCode;
  final dynamic data;
}
