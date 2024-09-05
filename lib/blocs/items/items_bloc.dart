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

  Future<String> getItemsGame() async {
    final response = await itemServices.getItemsGame();
    if (response != 'success') return response;
    add(OnGetItemsGameEvent(newItems: itemServices.itemsModel!));
    if (itemServices.itemsModel?.weapons == null || itemServices.itemsModel!.weapons!.isEmpty) return 'No Hay información de las Armas';
    if (state.selectedWeapon != null) return response; 
    add(OnSetSelectedWaponEvent(newSelectedWapon: itemServices.itemsModel!.weapons![0]));
    return response;
  }

  void setNewSelectedWapon({required Weapon newSelectedWeapon}) => add(OnSetSelectedWaponEvent(newSelectedWapon: newSelectedWeapon));
}
