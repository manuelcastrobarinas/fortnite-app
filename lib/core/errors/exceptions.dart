import 'package:fortnite_app/core/errors/api_error_type.dart';

/// Excepciones técnicas de la capa de datos.
///
/// Nunca cruzan hacia presentation: el repositorio las captura (vía
/// `FailureMapper`) y las traduce a un [Failure].
class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.message,
    this.code,
    this.details,
  });

  final int statusCode;
  final String message;

  /// Código de negocio del backend, cuando viene en el cuerpo.
  final String? code;

  /// Detalle de validación: `[{path, message}]` cuando el backend lo envía.
  final List<Map<String, dynamic>>? details;

  @override
  String toString() =>
      'ApiException($statusCode${code == null ? '' : ' $code'}): $message';
}

/// Fallo de comunicación (nunca llegó una respuesta HTTP utilizable).
class NetworkException implements Exception {
  const NetworkException(this.type, [this.details]);

  final ApiErrorType type;
  final String? details;

  String get message => type.message;

  @override
  String toString() =>
      'NetworkException(${type.name}): $message${details == null ? '' : ' — $details'}';
}

/// Regla de negocio detectada después de un HTTP exitoso
/// (cuenta inexistente, catálogo vacío, tienda sin datos).
class BusinessException implements Exception {
  const BusinessException(this.code);

  final String code;

  @override
  String toString() => 'BusinessException($code)';
}
