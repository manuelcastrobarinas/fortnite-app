import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/services/items/items.dart';

import 'package:fortnite_app/models/items/items.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {

  ItemServices itemServices;
  ItemsBloc({
    required this.itemServices
  }) : super(const ItemsState()) {
    on<OnGetItemsGameEvent>((event, emit) => emit(state.copyWith(items: event.newItems)));
    on<OnSetSelectedWaponEvent>((event, emit) => emit(state.copyWith(selectedWeapon: event.newSelectedWapon)));
  }

  Future<ItemsModel> getItemsGame() async {
    final ItemsModel response = await itemServices.getItemsGame();
    add(OnGetItemsGameEvent(newItems: response)); 
    
    if (state.selectedWeapon == null) {
      add(OnSetSelectedWaponEvent(newSelectedWapon: response.weapons![0]));
    }
    
    return response;
  }

  void setNewSelectedWapon({required Weapon newSelectedWeapon}) => add(OnSetSelectedWaponEvent(newSelectedWapon: newSelectedWeapon));
}
