import 'package:fortnite_app/features/items/domain/entities/items.dart';

/// Traduce `/v1/weapons` de prod.fn-api.cc al catálogo que pinta Inicio.
ItemsModel weaponsFromPublicBody(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is! List) {
    throw const FormatException('La respuesta de armas no trae data');
  }

  final weapons = <Weapon>[];
  final seen = <String>{};
  for (final raw in data) {
    if (raw is! Map) continue;
    final weapon = _weapon(Map<String, dynamic>.from(raw));
    if (weapon == null) continue;
    final id = weapon.id ?? weapon.name ?? '';
    if (id.isEmpty || !seen.add(id)) continue;
    weapons.add(weapon);
  }
  weapons.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  return ItemsModel(result: weapons.isNotEmpty, lang: 'en', weapons: weapons);
}

Weapon? _weapon(Map<String, dynamic> json) {
  final name = json['name']?.toString().trim() ?? '';
  final images = json['images'];
  final icon = images is Map ? images['icon']?.toString() : null;
  if (name.isEmpty || icon == null || icon.isEmpty) return null;

  final stats = json['stats'];
  if (stats is! Map) return null;
  final damage = stats['damage'];
  final close = damage is Map ? damage['close'] : damage;
  if (close is! num || close <= 0) return null;

  final rarityName = json['rarity']?.toString().toLowerCase();
  return Weapon(
    id: json['id']?.toString(),
    enabled: true,
    name: name,
    description: json['description']?.toString(),
    rarity: rarityValues.map[rarityName],
    searchTags: json['category']?.toString(),
    images: Images(icon: icon),
    mainStats: MainStats(
      dmgPb: close.toDouble(),
      firingRate: _asDouble(stats['firingRate']),
      clipSize: _clipSize(stats['clipSize']),
      reloadTime: _asDouble(stats['reloadTime']),
      bulletsPerCartridge: _asInt(stats['bulletsPerCartridge']),
      spread: _asDouble(stats['spread']),
      spreadDownsights: _asDouble(stats['spreadDownsights']),
      damageZoneCritical: _asDouble(stats['headshotMultiplier']),
    ),
  );
}

/// Algunos ítems de energía traen un cargador de millones. Eso no es un clip.
int? _clipSize(dynamic value) {
  final size = _asInt(value);
  if (size == null || size <= 0 || size > 500) return null;
  return size;
}

double? _asDouble(dynamic value) => value is num ? value.toDouble() : null;

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
