/// Catálogo de todos los tipos de error posibles al hablar con el backend.
///
/// Cada situación técnica tiene un tipo explícito con mensaje en español
/// listo para mostrar al usuario. La detección (qué excepción o status
/// produce cada tipo) vive en `failure_mapper.dart`.
enum ApiErrorType {
  connectionError,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  socketError,
  formatError,
  platformError,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  unprocessableEntity,
  tooManyRequests,
  serverError,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
  invalidResponse,
  htmlResponse,
  cancelled,
  unknownError;

  String get message => switch (this) {
        ApiErrorType.connectionError =>
          'No se pudo conectar con el servidor. Verifica tu conexión a internet.',
        ApiErrorType.connectionTimeout =>
          'No se pudo establecer la conexión con el servidor. Inténtalo de nuevo.',
        ApiErrorType.sendTimeout =>
          'Hubo un problema al enviar la solicitud. Inténtalo de nuevo.',
        ApiErrorType.receiveTimeout =>
          'El servidor tardó demasiado en responder. Inténtalo más tarde.',
        ApiErrorType.socketError =>
          'Problema de conexión. Verifica tu internet e intenta nuevamente.',
        ApiErrorType.formatError =>
          'Error al procesar los datos recibidos. Inténtalo más tarde.',
        ApiErrorType.platformError =>
          'Algo salió mal al obtener el recurso. Inténtalo más tarde.',
        ApiErrorType.badRequest => 'Solicitud incorrecta',
        ApiErrorType.unauthorized =>
          'No autorizado. Revisa el acceso a la API.',
        ApiErrorType.forbidden => 'No tienes permisos para esta acción.',
        ApiErrorType.notFound =>
          'El recurso que buscas no se encontró. Verifica la información e inténtalo de nuevo.',
        ApiErrorType.conflict => 'Conflicto con un recurso existente',
        ApiErrorType.unprocessableEntity => 'Los datos no pudieron procesarse',
        ApiErrorType.tooManyRequests =>
          'Demasiadas solicitudes. Espera un momento e inténtalo de nuevo.',
        ApiErrorType.serverError =>
          'Error interno del servidor. Inténtalo más tarde.',
        ApiErrorType.badGateway =>
          'El servidor no está disponible en este momento.',
        ApiErrorType.serviceUnavailable =>
          'Servicio en mantenimiento. Inténtalo más tarde.',
        ApiErrorType.gatewayTimeout =>
          'El servidor tardó demasiado en responder. Inténtalo más tarde.',
        ApiErrorType.invalidResponse =>
          'Error al procesar la respuesta del servidor. Inténtalo más tarde.',
        ApiErrorType.htmlResponse =>
          'El servidor devolvió una respuesta inesperada.',
        ApiErrorType.cancelled => 'La solicitud fue cancelada.',
        ApiErrorType.unknownError =>
          'Ocurrió un error inesperado. Inténtalo nuevamente.',
      };
}
