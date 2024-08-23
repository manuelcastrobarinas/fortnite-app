import 'package:bloc/bloc.dart';
import 'package:fortnite_app/services/items/items.dart';
import 'package:meta/meta.dart';

import 'package:fortnite_app/models/items/items.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {

  ItemServices itemServices;
  ItemsBloc({
    required this.itemServices
  }) : super(const ItemsState()) {
    on<OnGetItemsGameEvent>((event, emit) => emit(state.copyWith(items: event.newItems)));
  }

  Future<String> getItemsGame() async {
    final response = await itemServices.getItemsGame();
    if (response != 'success') return response;
    add(OnGetItemsGameEvent(newItems: itemServices.itemsModel!));
    return response;
  }
}
