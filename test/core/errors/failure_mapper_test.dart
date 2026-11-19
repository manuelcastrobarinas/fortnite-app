import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/core/errors/api_error_type.dart';
import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/errors/failures.dart';

void main() {
  group('FailureMapper', () {
    test('traduce un timeout de red a NetworkFailure', () {
      const error = NetworkException(ApiErrorType.connectionTimeout);
      final failure = FailureMapper.fromError(error);

      expect(failure, isA<NetworkFailure>());
      expect(failure.message, ApiErrorType.connectionTimeout.message);
    });

    test('traduce 404 a NotFoundFailure con el mensaje del backend', () {
      const error = ApiException(statusCode: 404, message: 'Jugador no existe');
      final failure = FailureMapper.fromError(error);

      expect(failure, isA<NotFoundFailure>());
      expect(failure.message, 'Jugador no existe');
    });

    test('traduce 401 a UnauthorizedFailure', () {
      const error = ApiException(statusCode: 401, message: '');
      final failure = FailureMapper.fromError(error);

      expect(failure, isA<UnauthorizedFailure>());
    });

    test('traduce un código de negocio de cuenta a NotFoundFailure', () {
      const error = BusinessException('ACCOUNT_NOT_FOUND');
      final failure = FailureMapper.fromError(error);

      expect(failure, isA<NotFoundFailure>());
      expect(failure.message, 'La cuenta ingresada no existe');
    });

    test('un error desconocido cae en UnexpectedFailure', () {
      final failure = FailureMapper.fromError(StateError('x'));

      expect(failure, isA<UnexpectedFailure>());
    });
  });
}
