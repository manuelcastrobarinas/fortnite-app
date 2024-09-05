part of 'items_bloc.dart';

class ItemsState  extends Equatable{
  final ItemsModel? items;
  final Weapon? selectedWeapon;
  
  const ItemsState({
    this.items,
    this.selectedWeapon
  });

  ItemsState copyWith({
    ItemsModel? items,
    Weapon? selectedWeapon
  }) => ItemsState(
    items: items ?? this.items,
    selectedWeapon: selectedWeapon ?? this.selectedWeapon
  );
  
  @override
  List<Object?> get props => [items, selectedWeapon];
}
