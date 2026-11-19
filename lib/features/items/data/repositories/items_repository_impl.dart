import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/items/data/datasources/items_remote_datasource.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/domain/repositories/items_repository.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  const ItemsRepositoryImpl(this._remote);

  final ItemsRemoteDataSource _remote;

  @override
  Future<Result<ItemsModel>> getItems() => _run(() async {
        final model = await _remote.fetchItems();
        final catalog = model.toEntity();
        if (catalog.weapons == null || catalog.weapons!.isEmpty) {
          throw const BusinessException('EMPTY_WEAPONS');
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
