part of 'items_bloc.dart';

class ItemsState {
  final ItemsModel? items;

  const ItemsState({
    this.items
  });

  ItemsState copyWith({
    ItemsModel? items,
  }) => ItemsState(
    items: items ?? this.items,
  );
}
