/// Contenedor de dependencias minimalista (sin paquetes externos).
///
/// Soporta singletons perezosos y fábricas. Cuando el proyecto lo amerite,
/// se puede reemplazar por get_it manteniendo la misma API de registro
/// en `app/di/injection.dart`.
class ServiceLocator {
  final Map<Type, Object Function()> _factories = {};
  final Map<Type, Object Function()> _lazyBuilders = {};
  final Map<Type, Object> _singletons = {};

  /// Registra una instancia única que se construye en el primer `get`.
  void registerLazySingleton<T extends Object>(T Function() builder) {
    _lazyBuilders[T] = builder;
  }

  /// Registra una fábrica: cada `get` devuelve una instancia nueva.
  void registerFactory<T extends Object>(T Function() builder) {
    _factories[T] = builder;
  }

  T get<T extends Object>() {
    final singleton = _singletons[T];
    if (singleton != null) return singleton as T;

    final lazyBuilder = _lazyBuilders[T];
    if (lazyBuilder != null) {
      final instance = lazyBuilder() as T;
      _singletons[T] = instance;
      return instance;
    }

    final factory = _factories[T];
    if (factory != null) return factory() as T;

    throw StateError(
      'No hay registro para $T. ¿Olvidaste llamar a setupDependencies()?',
    );
  }

  bool isRegistered<T extends Object>() =>
      _singletons.containsKey(T) ||
      _lazyBuilders.containsKey(T) ||
      _factories.containsKey(T);

  void reset() {
    _factories.clear();
    _lazyBuilders.clear();
    _singletons.clear();
  }
}

/// Instancia global del locator (composition root en `app/di/injection.dart`).
final ServiceLocator sl = ServiceLocator();
