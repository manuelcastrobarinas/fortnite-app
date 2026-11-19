import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';

abstract class ShopRepository {
  Future<Result<ShopLimited>> getShop();
}
