import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  const ShopRepositoryImpl(this._remote);

  final ShopRemoteDataSource _remote;

  @override
  Future<Result<ShopLimited>> getShop() => _run(() async {
        final model = await _remote.fetchShop();
        final catalog = model.toEntity();
        if (catalog.result == false) {
          throw const BusinessException('SHOP_UNAVAILABLE');
        }
        return catalog;
      });

  Future<Result<T>> _run<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } catch (error) {
      return Err(FailureMapper.fromError(error));
    }
  }
}
