import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/domain/repositories/items_repository.dart';

class GetItemsUseCase {
  const GetItemsUseCase(this._repository);

  final ItemsRepository _repository;

  Future<Result<ItemsModel>> call() => _repository.getItems();
}
