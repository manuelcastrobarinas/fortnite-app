import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';

class ShopLimitedResponseModel {
  const ShopLimitedResponseModel(this.catalog);

  final ShopLimited catalog;

  factory ShopLimitedResponseModel.fromJson(Map<String, dynamic> json) {
    return ShopLimitedResponseModel(ShopLimited.fromJson(json));
  }

  ShopLimited toEntity() => catalog;
}
