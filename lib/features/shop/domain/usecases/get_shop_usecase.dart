import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/repositories/shop_repository.dart';

class GetShopUseCase {
  const GetShopUseCase(this._repository);

  final ShopRepository _repository;

  Future<Result<ShopLimited>> call() => _repository.getShop();
}
