/// Catálogo de códigos de negocio que la app reconoce después de parsear
/// una respuesta HTTP exitosa, o que el backend manda en `{ message, code }`.
///
/// Cada código tiene un mensaje amigable. Los repositorios lanzan
/// [BusinessException] con estos códigos; `FailureMapper` es quien los
/// convierte en [Failure].
abstract class BackendErrorCatalog {
  static const Map<String, String> core = {
    'VALIDATION': 'Los datos enviados no son válidos',
    'CONFLICT': 'Conflicto con un recurso existente',
    'NOT_FOUND': 'El recurso no existe',
    'BUSINESS_RULE': 'La operación viola una regla de negocio',
    'INTERNAL': 'Error interno del servidor',
  };

  static const Map<String, String> fortnite = {
    'EMPTY_NEWS': 'No existen noticias disponibles',
    'EMPTY_WEAPONS': 'No hay información de las armas',
    'ACCOUNT_NOT_FOUND': 'La cuenta ingresada no existe',
    'ACCOUNT_ID_MISSING': 'No se encontró el ID de la cuenta',
    'SHOP_UNAVAILABLE':
        'No se ha podido obtener información de la tienda. Inténtalo más tarde.',
  };

  static const Set<String> nonBlocking = {
    'CONFLICT',
  };

  static String? messageFor(String code) => core[code] ?? fortnite[code];

  /// Por defecto un código desconocido se considera bloqueante.
  static bool isBlocking(String code) => !nonBlocking.contains(code);
}
