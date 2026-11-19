import 'package:fortnite_app/core/errors/failures.dart';

/// Resultado de una operación que puede fallar.
///
/// Los repositorios y casos de uso devuelven `Result<T>` en vez de lanzar
/// excepciones: la UI está obligada por el compilador a manejar ambos caminos.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;

  /// Valor en caso de éxito. Solo debe llamarse si [isOk] es true.
  T get value => (this as Ok<T>).data;

  /// Fallo en caso de error. Solo debe llamarse si [isOk] es false.
  Failure get failure => (this as Err<T>).error;

  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T value) onSuccess,
  });
}

final class Ok<T> extends Result<T> {
  const Ok(this.data);

  final T data;

  @override
  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T value) onSuccess,
  }) =>
      onSuccess(data);
}

final class Err<T> extends Result<T> {
  const Err(this.error);

  final Failure error;

  @override
  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T value) onSuccess,
  }) =>
      onFailure(error);
}
