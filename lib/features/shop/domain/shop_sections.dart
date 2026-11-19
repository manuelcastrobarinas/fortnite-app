import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';

/// Tienda partida por tipo de ítem. La clasificación vive en dominio:
/// el bloc solo publica el resultado.
class ShopSections {
  const ShopSections({
    this.alaDeltas = const [],
    this.wrappers = const [],
    this.gestures = const [],
    this.bundles = const [],
    this.music = const [],
    this.pickaxes = const [],
    this.lego = const [],
    this.skins = const [],
  });

  final List<Shop> alaDeltas;
  final List<Shop> wrappers;
  final List<Shop> gestures;
  final List<Shop> bundles;
  final List<Shop> music;
  final List<Shop> pickaxes;
  final List<Shop> lego;
  final List<Shop> skins;

  factory ShopSections.group(List<Shop>? entries) {
    if (entries == null || entries.isEmpty) return const ShopSections();

    final alaDeltas = <Shop>[];
    final wrappers = <Shop>[];
    final gestures = <Shop>[];
    final bundles = <Shop>[];
    final music = <Shop>[];
    final pickaxes = <Shop>[];
    final lego = <Shop>[];
    final skins = <Shop>[];

    for (final shop in entries) {
      switch (shop.displayType) {
        case DisplayType.ALA_DELTA:
          alaDeltas.add(shop);
        case DisplayType.ENVOLTORIO:
          wrappers.add(shop);
        case DisplayType.GESTO:
          gestures.add(shop);
        case DisplayType.LOTE_DE_4_OBJETO_S:
        case DisplayType.LOTE_DE_5_OBJETO_S:
        case DisplayType.LOTE_DE_OBJETOS:
          bundles.add(shop);
        case DisplayType.MUSICA:
          music.add(shop);
        case DisplayType.PICOS:
          pickaxes.add(shop);
        case DisplayType.PLAYSET_PROP:
          lego.add(shop);
        case DisplayType.TRAJE:
          skins.add(shop);
        default:
          break;
      }
    }

    return ShopSections(
      alaDeltas: alaDeltas,
      wrappers: wrappers,
      gestures: gestures,
      bundles: bundles,
      music: music,
      pickaxes: pickaxes,
      lego: lego,
      skins: skins,
    );
  }
}
