import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Acceso centralizado a variables de entorno (`.env`).
///
/// Las URLs y el token viven solo en el `.env`; el código nunca hardcodea hosts.
abstract class EnvConfig {
  static const String limitedApiUrlKey = 'API_LIMITED_URL';
  static const String limitedApiUrlV2Key = 'API_LIMITED_URL_V2';
  static const String accessTokenKey = 'ACCESS_TOKEN_LIMITED_API';
  static const String publicApiUrlKey = 'PUBLIC_API_URL';

  /// URL base de noticias, armas y jugadores, sin barra final.
  static String get limitedApiUrl => _readRequiredUrl(limitedApiUrlKey);

  /// URL base de la tienda (v2), sin barra final.
  static String get limitedApiUrlV2 => _readRequiredUrl(limitedApiUrlV2Key);

  /// Token que la API limitada espera en el header `Authorization`.
  static String get accessToken => _readRequired(accessTokenKey);

  /// API pública gratuita (mapa, modos y cosméticos). No usa el token de pago.
  static String get publicApiUrl => _readRequiredUrl(publicApiUrlKey);

  static String _readRequired(String key) {
    final raw = dotenv.maybeGet(key)?.trim();
    if (raw == null || raw.isEmpty) {
      throw StateError('$key está vacío. Revisa el archivo .env.');
    }
    return _stripQuotes(raw);
  }

  static String _stripQuotes(String value) {
    if (value.length < 2) return value;
    final quote = value[0];
    if ((quote == "'" || quote == '"') && value.endsWith(quote)) {
      return value.substring(1, value.length - 1).trim();
    }
    return value;
  }

  static String _readRequiredUrl(String key) =>
      _stripTrailingSlash(_readRequired(key));

  static String _stripTrailingSlash(String url) {
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }
}
