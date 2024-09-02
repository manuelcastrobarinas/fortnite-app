part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class OnGetItemsGameEvent extends ItemsEvent {
  final ItemsModel newItems;

  const OnGetItemsGameEvent({
    required this.newItems
  });
}

class OnSetSelectedWaponEvent extends ItemsEvent {
  final Weapon newSelectedWapon;
  
  const OnSetSelectedWaponEvent({
    required this.newSelectedWapon
  });
}