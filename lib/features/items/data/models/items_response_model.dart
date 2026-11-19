import 'package:fortnite_app/features/items/domain/entities/items.dart';

class ItemsResponseModel {
  const ItemsResponseModel(this.catalog);

  final ItemsModel catalog;

  factory ItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemsResponseModel(ItemsModel.fromJson(json));
  }

  ItemsModel toEntity() => catalog;
}
