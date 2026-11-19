import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/shop_sections.dart';
import 'package:fortnite_app/features/shop/domain/usecases/get_shop_usecase.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({required GetShopUseCase getShop})
      : _getShop = getShop,
        super(const ShopState()) {
    on<OnSetSelectedShopItemEvent>(
      (event, emit) => emit(state.copyWith(itemShopSelected: event.newItemShop)),
    );
    on<OnSetNewIndexChipEvent>(
      (event, emit) => emit(state.copyWith(indexChipSelected: event.newIndex)),
    );
    on<OnUpdateIndexShopEvent>(
      (event, emit) => emit(state.copyWith(indexShop: event.newIndex)),
    );
    on<OnLoadMoreElementsEvent>(
      (event, emit) => emit(state.copyWith(itemsPerPage: event.itemsPerPage)),
    );
    on<OnLoadAllShopsEvent>(
      (event, emit) => emit(
        state.copyWith(
          alaDeltasShop: event.alaDeltasShop,
          wrappersShop: event.envoltoriosShop,
          gesturesShop: event.gestosShop,
          loteDeObjetosShopCompletos: event.loteDeObjetosShopCompletos,
          musicShop: event.musicaShop,
          picosShop: event.picosShop,
          playSetProp: event.playSetProp,
          skinsShop: event.trajeShop,
        ),
      ),
    );
  }

  final GetShopUseCase _getShop;

  Future<String> getShopLimited() async {
    final result = await _getShop();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (catalog) {
        updateAllShops(shops: catalog.shop);
        return 'success';
      },
    );
  }

  void setSelectedShopItem({required Shop newSelectedItem}) {
    add(OnSetSelectedShopItemEvent(newItemShop: newSelectedItem));
  }

  void updateAllShops({required List<Shop>? shops}) {
    final sections = ShopSections.group(shops);
    add(
      OnLoadAllShopsEvent(
        alaDeltasShop: sections.alaDeltas,
        envoltoriosShop: sections.wrappers,
        gestosShop: sections.gestures,
        loteDeObjetosShopCompletos: sections.bundles,
        musicaShop: sections.music,
        picosShop: sections.pickaxes,
        playSetProp: sections.lego,
        trajeShop: sections.skins,
      ),
    );
  }

  void setIndexSelectedItemShop(int i) => add(OnUpdateIndexShopEvent(newIndex: i));

  void setNewIndexChip(int i) => add(OnSetNewIndexChipEvent(newIndex: i));
}
