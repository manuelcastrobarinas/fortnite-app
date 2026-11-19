import 'dart:async';

import 'package:fortnite_app/core/errors/api_error_type.dart';
import 'package:fortnite_app/core/errors/backend_error_catalog.dart';
import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failures.dart';

/// Traductor central de errores técnicos a [Failure]s de dominio.
///
/// Un solo lugar donde cualquier cosa que pueda salir mal (excepciones de
/// red, códigos HTTP, errores de parsing, códigos de negocio) se convierte
/// en un tipo que la UI sabe manejar. Los repositorios lo usan en su
/// `guard`; ningún otro lugar de la app traduce errores.
abstract class FailureMapper {
  static Failure fromError(Object error) {
    if (error is NetworkException) return NetworkFailure(error.message);
    if (error is ApiException) return _fromApiException(error);
    if (error is BusinessException) return _fromBusinessException(error);
    if (error is FormatException || error is TypeError) {
      return ServerFailure(ApiErrorType.formatError.message);
    }
    if (error is TimeoutException) {
      return NetworkFailure(ApiErrorType.receiveTimeout.message);
    }
    return const UnexpectedFailure();
  }

  static Failure _fromBusinessException(BusinessException exception) {
    final message = BackendErrorCatalog.messageFor(exception.code) ??
        ApiErrorType.unknownError.message;

    return switch (exception.code) {
      'ACCOUNT_NOT_FOUND' ||
      'ACCOUNT_ID_MISSING' ||
      'EMPTY_NEWS' ||
      'EMPTY_WEAPONS' =>
        NotFoundFailure(message),
      'SHOP_UNAVAILABLE' => ServerFailure(message),
      _ => ValidationFailure(
          message,
          isBlocking: BackendErrorCatalog.isBlocking(exception.code),
          code: exception.code,
        ),
    };
  }

  static Failure _fromApiException(ApiException exception) {
    final catalogMessage = exception.code != null
        ? BackendErrorCatalog.messageFor(exception.code!)
        : null;
    final message = exception.message.isNotEmpty
        ? exception.message
        : (catalogMessage ?? ApiErrorType.unknownError.message);

    final fieldErrors = (exception.details ?? const [])
        .map(
          (detail) => (
            path: detail['path']?.toString() ?? '',
            message: detail['message']?.toString() ?? '',
          ),
        )
        .toList();

    final isBlocking = exception.code == null
        ? true
        : BackendErrorCatalog.isBlocking(exception.code!);

    return switch (exception.statusCode) {
      400 => ValidationFailure(
          message,
          fieldErrors: fieldErrors,
          isBlocking: isBlocking,
          code: exception.code,
        ),
      401 => UnauthorizedFailure(message),
      403 => ForbiddenFailure(message),
      404 => NotFoundFailure(message),
      409 => ValidationFailure(
          message,
          isBlocking: isBlocking,
          code: exception.code,
        ),
      422 => ValidationFailure(
          message,
          fieldErrors: fieldErrors,
          isBlocking: isBlocking,
          code: exception.code,
        ),
      429 => const RateLimitFailure(),
      502 || 503 || 504 => const ServiceUnavailableFailure(),
      >= 500 => ServerFailure(message, statusCode: exception.statusCode),
      _ => ServerFailure(message, statusCode: exception.statusCode),
    };
  }
}
