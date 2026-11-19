/// Mapa actual de Battle Royale y los puntos con nombre.
class BrMap {
  const BrMap({
    this.labeledImageUrl,
    this.blankImageUrl,
    this.pois = const [],
  });

  final String? labeledImageUrl;
  final String? blankImageUrl;
  final List<MapPoi> pois;

  String? get displayImageUrl {
    final labeled = labeledImageUrl?.trim();
    if (labeled != null && labeled.isNotEmpty) return labeled;
    final blank = blankImageUrl?.trim();
    if (blank != null && blank.isNotEmpty) return blank;
    return null;
  }

  factory BrMap.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    final imageMap = images is Map
        ? Map<String, dynamic>.from(images)
        : const <String, dynamic>{};
    final pois = <MapPoi>[];
    final rawPois = json['pois'];
    if (rawPois is List) {
      for (final item in rawPois) {
        if (item is! Map) continue;
        final name = item['name']?.toString().trim() ?? '';
        if (name.isEmpty) continue;
        pois.add(MapPoi(
          id: item['id']?.toString() ?? name,
          name: name,
        ));
      }
    }
    pois.sort((a, b) => a.name.compareTo(b.name));
    return BrMap(
      labeledImageUrl: imageMap['pois']?.toString(),
      blankImageUrl: imageMap['blank']?.toString(),
      pois: pois,
    );
  }
}

class MapPoi {
  const MapPoi({required this.id, required this.name});

  final String id;
  final String name;
}

/// Modo de juego que trae imagen. Se descartan las playlists internas.
class GameMode {
  const GameMode({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.teamSize,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int? teamSize;

  static List<GameMode> fromApiList(List<dynamic> raw) {
    final modes = <GameMode>[];
    final seen = <String>{};
    for (final item in raw) {
      if (item is! Map) continue;
      final images = item['images'];
      String? image;
      if (images is Map) {
        final showcase = images['showcase']?.toString();
        final icon = images['missionIcon']?.toString();
        image = (showcase != null && showcase.isNotEmpty) ? showcase : icon;
      }
      if (image == null || image.isEmpty) continue;
      final name = item['name']?.toString().trim() ?? '';
      if (name.isEmpty) continue;
      final id = item['id']?.toString() ?? name;
      if (!seen.add(id)) continue;
      final team = item['maxTeamSize'];
      modes.add(GameMode(
        id: id,
        name: name,
        description: item['description']?.toString().trim() ?? '',
        imageUrl: image,
        teamSize: team is num && team > 0 ? team.toInt() : null,
      ));
    }
    modes.sort((a, b) => a.name.compareTo(b.name));
    return modes;
  }
}

/// Cosmético aparecido en el último parche de archivos del juego.
class NewCosmetic {
  const NewCosmetic({
    required this.id,
    required this.name,
    required this.typeLabel,
    required this.rarityLabel,
    required this.groupLabel,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String typeLabel;
  final String rarityLabel;
  final String groupLabel;
  final String? imageUrl;

  static const groupLabels = <String, String>{
    'br': 'Battle Royale',
    'tracks': 'Pista',
    'instruments': 'Instrumento',
    'cars': 'Vehículo',
    'lego': 'LEGO',
  };

  static List<NewCosmetic> fromGroups(Map<String, dynamic> groups) {
    final cosmetics = <NewCosmetic>[];
    final seen = <String>{};
    for (final entry in groupLabels.entries) {
      final raw = groups[entry.key];
      if (raw is! List) continue;
      for (final item in raw) {
        if (item is! Map) continue;
        final name = item['name']?.toString().trim() ?? '';
        if (name.isEmpty) continue;
        final id = item['id']?.toString() ?? name;
        if (!seen.add(id)) continue;
        cosmetics.add(NewCosmetic(
          id: id,
          name: name,
          typeLabel: _display(item['type']) ?? entry.value,
          rarityLabel: _display(item['rarity']) ?? '',
          groupLabel: entry.value,
          imageUrl: _image(item['images']),
        ));
      }
    }
    return cosmetics;
  }

  static String? _display(dynamic value) {
    if (value is! Map) return null;
    final text = value['displayValue']?.toString().trim();
    if (text == null || text.isEmpty) return null;
    return text;
  }

  static String? _image(dynamic images) {
    if (images is! Map) return null;
    for (final key in ['icon', 'smallIcon', 'featured']) {
      final url = images[key]?.toString().trim();
      if (url != null && url.isNotEmpty) return url;
    }
    return null;
  }
}

/// Código de Support-a-Creator. La API pública lo resuelve sin llave.
class CreatorCode {
  const CreatorCode({
    required this.code,
    required this.accountId,
    required this.accountName,
    required this.status,
    required this.verified,
  });

  final String code;
  final String accountId;
  final String accountName;
  final String status;
  final bool verified;

  String get statusLabel {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return 'Activo';
      case 'INACTIVE':
      case 'DISABLED':
        return 'Inactivo';
      default:
        return status.trim().isEmpty ? 'Sin estado' : status;
    }
  }

  factory CreatorCode.fromJson(Map<String, dynamic> json) {
    final account = json['account'];
    final accountMap = account is Map
        ? Map<String, dynamic>.from(account)
        : const <String, dynamic>{};
    return CreatorCode(
      code: json['code']?.toString().trim() ?? '',
      accountId: accountMap['id']?.toString() ?? '',
      accountName: accountMap['name']?.toString().trim().isNotEmpty == true
          ? accountMap['name'].toString().trim()
          : 'Sin nombre',
      status: json['status']?.toString() ?? '',
      verified: json['verified'] == true,
    );
  }
}
