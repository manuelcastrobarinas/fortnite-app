/// Jerarquía de errores de dominio de la aplicación.
///
/// La capa de datos captura las excepciones técnicas (dio, sockets,
/// parsing) y las traduce a un [Failure] mediante `FailureMapper`.
/// La UI solo conoce estos tipos: mostrar mensajes al usuario nunca
/// depende de detalles de infraestructura.
sealed class Failure {
  const Failure(this.message);

  /// Mensaje listo para mostrar al usuario (en español).
  final String message;

  @override
  String toString() => message;
}

/// Error de comunicación: sin conexión, timeout, DNS, cancelación.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Error de conexión']);
}

/// El backend respondió con un error técnico (5xx / respuesta inválida).
class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;
}

/// Error de validación o regla de negocio mostrable en la UI.
class ValidationFailure extends Failure {
  const ValidationFailure(
    super.message, {
    this.fieldErrors = const [],
    this.isBlocking = true,
    this.code,
  });

  final List<({String path, String message})> fieldErrors;
  final bool isBlocking;
  final String? code;
}

/// El recurso solicitado no existe (404 o regla de "no encontrado").
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Sin autenticación válida (401).
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'No autorizado. Revisa el acceso a la API.',
  ]);
}

/// Autenticado pero sin permisos para el recurso (403).
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([
    super.message = 'No tienes permisos para esta acción.',
  ]);
}

/// Rate limit del backend excedido (429).
class RateLimitFailure extends Failure {
  const RateLimitFailure([
    super.message =
        'Demasiadas solicitudes. Espera un momento e inténtalo de nuevo.',
  ]);
}

/// Servicio caído o en mantenimiento (502/503/504).
class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure([
    super.message =
        'Servicio no disponible en este momento. Inténtalo más tarde.',
  ]);
}

/// Cualquier error no clasificado.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'Ocurrió un error inesperado. Inténtalo nuevamente.',
  ]);
}
