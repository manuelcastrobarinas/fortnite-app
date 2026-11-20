import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';

/// Traduce la tienda de fortnite-api.com (`/v2/shop`) al [ShopLimited]
/// que ya pintan las pestañas.
ShopLimited shopFromPublicBody(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is! Map) {
    throw const FormatException('La respuesta de la tienda no trae data');
  }
  final entries = data['entries'];
  if (entries is! List) {
    throw const FormatException('La respuesta de la tienda no trae entries');
  }

  final offers = <Shop>[];
  for (final raw in entries) {
    if (raw is! Map) continue;
    final offer = _offer(Map<String, dynamic>.from(raw));
    if (offer != null) offers.add(offer);
  }

  return ShopLimited(
    result: offers.isNotEmpty,
    fullShop: true,
    lastUpdate: LastUpdate(
      date: DateTime.tryParse('${data['date']}'),
      uid: data['hash']?.toString(),
    ),
    shop: offers,
  );
}

Shop? _offer(Map<String, dynamic> entry) {
  final price = Price(
    regularPrice: _asInt(entry['regularPrice']),
    finalPrice: _asInt(entry['finalPrice']),
  );
  final colors = _colors(entry['colors']);
  final cosmetics = _maps(entry['brItems']);

  // Dos piezas (skin + mochila) se quedan en la sección de la primera.
  // El carrusel de lotes pinta todas las cartas a la vez; un lote por cada
  // pareja dejaba esa pestaña congelada.
  if (cosmetics.length > 2) {
    return _fromCosmetics(
      cosmetics,
      displayType: DisplayType.LOTE_DE_OBJETOS,
      price: price,
      colors: colors,
      offerId: entry['offerId']?.toString(),
    );
  }
  if (cosmetics.isNotEmpty) {
    Map<String, dynamic>? shown;
    for (final item in cosmetics) {
      if (_displayType(item['type']) != null) {
        shown = item;
        break;
      }
    }
    if (shown == null) return null;
    return _fromCosmetics(
      [shown],
      displayType: _displayType(shown['type'])!,
      price: price,
      colors: colors,
      offerId: entry['offerId']?.toString(),
    );
  }

  final tracks = _maps(entry['tracks']);
  if (tracks.isNotEmpty) {
    return _fromTrack(tracks.first, price: price, colors: colors, offerId: entry['offerId']?.toString());
  }
  return null;
}

Shop? _fromCosmetics(
  List<Map<String, dynamic>> cosmetics, {
  required DisplayType displayType,
  required Price price,
  required ColorsItems? colors,
  required String? offerId,
}) {
  final granted = <Granted>[];
  for (final item in cosmetics) {
    final name = _text(item['name']);
    final image = _cosmeticImage(item['images']);
    if (name.isEmpty || image == null) continue;
    granted.add(
      Granted(
        id: item['id']?.toString(),
        name: name,
        description: _text(item['description']),
        images: Images(icon: image, featured: image),
      ),
    );
  }
  if (granted.isEmpty) return null;
  final first = granted.first;
  final title = granted.length == 1
      ? first.name!
      : '${first.name} y ${granted.length - 1} más';
  return Shop(
    offerId: offerId,
    displayName: title,
    displayDescription: first.description,
    displayType: displayType,
    price: price,
    colors: colors,
    displayAssets: [DisplayAsset(url: first.images?.icon)],
    granted: granted,
  );
}

Shop? _fromTrack(
  Map<String, dynamic> track, {
  required Price price,
  required ColorsItems? colors,
  required String? offerId,
}) {
  final title = _text(track['title']);
  final image = _text(track['albumArt']);
  if (title.isEmpty || image.isEmpty) return null;
  final artist = _text(track['artist']);
  return Shop(
    offerId: offerId,
    displayName: title,
    displayDescription: artist,
    displayType: DisplayType.MUSICA,
    price: price,
    colors: colors,
    displayAssets: [DisplayAsset(url: image)],
    granted: [
      Granted(
        id: track['id']?.toString(),
        name: title,
        description: artist,
        images: Images(icon: image),
      ),
    ],
  );
}

DisplayType? _displayType(dynamic type) {
  final value = type is Map ? type['value']?.toString() : type?.toString();
  return switch (value) {
    'outfit' => DisplayType.TRAJE,
    'pickaxe' => DisplayType.PICOS,
    'glider' => DisplayType.ALA_DELTA,
    'emote' => DisplayType.GESTO,
    'wrap' => DisplayType.ENVOLTORIO,
    'contrail' => DisplayType.ESTELA,
    'lego' => DisplayType.PLAYSET_PROP,
    _ => null,
  };
}

ColorsItems? _colors(dynamic raw) {
  if (raw is! Map) return null;
  return ColorsItems(
    color1: _flutterHex(raw['color1']),
    color2: _flutterHex(raw['color2']),
    color3: _flutterHex(raw['color3']),
    textBackgroundColor: _flutterHex(raw['textBackgroundColor']),
  );
}

/// fortnite-api.com manda `RRGGBBAA`. El color de la UI espera `AARRGGBB`.
String? _flutterHex(dynamic raw) {
  final text = raw?.toString().trim() ?? '';
  if (text.isEmpty) return null;
  var hex = text.startsWith('#') ? text.substring(1) : text;
  if (hex.length == 8) {
    hex = hex.substring(6) + hex.substring(0, 6);
  }
  return '#$hex';
}

List<Map<String, dynamic>> _maps(dynamic raw) {
  if (raw is! List) return const [];
  return [
    for (final item in raw)
      if (item is Map) Map<String, dynamic>.from(item),
  ];
}

String? _cosmeticImage(dynamic raw) {
  if (raw is! Map) return null;
  for (final key in ['featured', 'icon', 'smallIcon']) {
    final value = _text(raw[key]);
    if (value.isNotEmpty) return value;
  }
  return null;
}

String _text(dynamic value) => value?.toString().trim() ?? '';

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
