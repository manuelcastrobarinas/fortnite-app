import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';

abstract class ItemsRepository {
  Future<Result<ItemsModel>> getItems();
}
