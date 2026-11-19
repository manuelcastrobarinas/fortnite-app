import 'package:flutter/material.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';

/// Convierte un color de la API (`#RRGGBB` o `#AARRGGBB`) al formato de Flutter.
/// Si el valor no es un hexadecimal válido, devuelve null.
Color? colorFromShopHex(String? raw) {
  if (raw == null) return null;
  var hex = raw.trim();
  if (hex.isEmpty) return null;
  if (hex.startsWith('#')) hex = hex.substring(1);
  if (hex.startsWith('0x') || hex.startsWith('0X')) hex = hex.substring(2);
  if (hex.length == 6) hex = 'FF$hex';
  if (hex.length != 8) return null;
  final value = int.tryParse(hex, radix: 16);
  if (value == null) return null;
  return Color(value);
}

/// Color de fondo de una oferta. Usa el primer hexadecimal válido de la API.
Color replaceShopColorWithDartFormat(Shop shopElement) {
  final colors = shopElement.colors;
  return colorFromShopHex(colors?.color1) ??
      colorFromShopHex(colors?.color2) ??
      colorFromShopHex(colors?.color3) ??
      Colors.black;
}

/// Datos mínimos para pintar una oferta sin forzar nulos.
class ShopOfferPreview {
  const ShopOfferPreview({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.color,
  });

  final String title;
  final String imageUrl;
  final int price;
  final String description;
  final Color color;
}

Granted? shopGrantedAt(Shop shop, int index) {
  final granted = shop.granted;
  if (granted == null || index < 0 || index >= granted.length) return null;
  return granted[index];
}

String? shopGrantedIcon(Shop shop, int index) =>
    shopGrantedAt(shop, index)?.images?.icon;

String? shopGrantedName(Shop shop, int index) =>
    shopGrantedAt(shop, index)?.name;

String shopBundleImage(Shop shop) {
  final assets = shop.displayAssets;
  final assetUrl =
      (assets != null && assets.isNotEmpty) ? assets.first.url : null;
  if (assetUrl != null && assetUrl.isNotEmpty) return assetUrl;
  return shopGrantedIcon(shop, 0) ?? '';
}

/// Null cuando la oferta no trae una imagen que se pueda mostrar.
ShopOfferPreview? shopOfferPreview(Shop shop) {
  final image = shopBundleImage(shop);
  if (image.isEmpty) return null;
  final first = shopGrantedAt(shop, 0);
  final price = shop.price?.finalPrice ??
      shop.price?.regularPrice ??
      shop.price?.floorPrice ??
      0;
  return ShopOfferPreview(
    title: shop.displayName ?? first?.name ?? 'Nombre no disponible',
    imageUrl: image,
    price: price,
    description: shop.displayDescription ??
        first?.description ??
        'Descripcion no disponible',
    color: replaceShopColorWithDartFormat(shop),
  );
}
