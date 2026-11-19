import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/domain/usecases/get_items_usecase.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc({required GetItemsUseCase getItems})
      : _getItems = getItems,
        super(const ItemsState()) {
    on<OnGetItemsGameEvent>(
      (event, emit) => emit(state.copyWith(items: event.newItems)),
    );
    on<OnSetSelectedWaponEvent>(
      (event, emit) => emit(state.copyWith(selectedWeapon: event.newSelectedWapon)),
    );
  }

  final GetItemsUseCase _getItems;

  Future<ItemsModel> getItemsGame() async {
    final result = await _getItems();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (response) {
        add(OnGetItemsGameEvent(newItems: response));
        if (state.selectedWeapon == null &&
            response.weapons != null &&
            response.weapons!.isNotEmpty) {
          add(OnSetSelectedWaponEvent(newSelectedWapon: response.weapons![0]));
        }
        return response;
      },
    );
  }

  void setNewSelectedWapon({required Weapon newSelectedWeapon}) {
    add(OnSetSelectedWaponEvent(newSelectedWapon: newSelectedWeapon));
  }
}
