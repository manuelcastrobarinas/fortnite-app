/// Rutas relativas del API (contrato HTTP).
///
/// La URL base vive en `.env` y se lee vía [EnvConfig]. Aquí solo van paths.
abstract class ApiPaths {
  static const String news = '/news';
  static const String lootList = '/loot/list';
  static const String lookup = '/lookup';
  static const String stats = '/stats';
  static const String shop = '/shop';

  /// fortnite-api.com, sin llave.
  static const String publicMap = '/v1/map';
  static const String publicPlaylists = '/v1/playlists';
  static const String publicNewCosmetics = '/v2/cosmetics/new';
  static const String publicCreatorCode = '/v2/creatorcode';
}
