import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/services/shop/shop_services.dart';

import '../../models/shop/shop_limited.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {

  final ShopServices shopServices;
  ShopBloc({
    required this.shopServices
  }) : super(const ShopState()) {
    // on<OnGetShopLimitedEvent>     ((event, emit) => emit(state.copyWith(shopAll: event.shopLimited)));
    on<OnSetSelectedShopItemEvent>((event, emit) => emit(state.copyWith(itemShopSelected: event.newItemShop)));
    // on<OnLoadShopDataEvent>       ((event, emit) => emit(state.copyWith(shopDataLoad: [...state.shopDataLoad + event.newListShop])));
    on<OnSetNewIndexChipEvent>    ((event, emit) => emit(state.copyWith(indexChipSelected: event.newIndex)));
    on<OnUpdateIndexShopEvent>    ((event, emit) => emit(state.copyWith(indexShop: event.newIndex)));
    on<OnLoadAllShopsEvent>       ((event, emit) => emit(state.copyWith(
      alaDeltasShop   : event.alaDeltasShop,
      envoltoriosShop : event.envoltoriosShop,
      gestosShop      : event.gestosShop,
      loteDeObjetosShopCompletos  : event.loteDeObjetosShopCompletos,
      musicaShop    : event.musicaShop,
      picosShop     : event.picosShop,
      playSetProp   : event.playSetProp,
      trajeShop     : event.trajeShop
    )));
  }

  Future<void> getShopLimited() async {
    final ShopLimited response = await shopServices.getShop();
    if (response.result == false) throw 'No ser ha podido obtener informacion de la tienda, intentelo mas tarde';
    updateAllShops(shops: response.shop);
  }

  void setSelectedShopItem({required Shop newSelectedItem }) => add(OnSetSelectedShopItemEvent(newItemShop: newSelectedItem));

  void updateAllShops({required List<Shop>? shops}) {
    List<Shop> alaDeltasShop      = <Shop>[];
    List<Shop> envoltoriosShop    = <Shop>[];
    List<Shop> gestosShop         = <Shop>[];
    List<Shop> loteDeObjetosShopCompletos = <Shop>[];
    List<Shop> musicaShop         = <Shop>[];
    List<Shop> picosShop          = <Shop>[];
    List<Shop> playSetProp        = <Shop>[];
    List<Shop> trajeShop          = <Shop>[];

    if (shops!.isEmpty) return ;
    for (Shop shop in shops) {
      switch (shop.displayType) {
          case DisplayType.ALA_DELTA:
            alaDeltasShop.add(shop);
          break;
          case DisplayType.ENVOLTORIO:
            envoltoriosShop.add(shop);
          break;
          case DisplayType.GESTO:
            gestosShop.add(shop);
          break;
          case DisplayType.LOTE_DE_4_OBJETO_S:
            loteDeObjetosShopCompletos.add(shop);
          break;
          case DisplayType.LOTE_DE_5_OBJETO_S:
            loteDeObjetosShopCompletos.add(shop);
          break;
          case DisplayType.LOTE_DE_OBJETOS:
            loteDeObjetosShopCompletos.add(shop);
          break;
          case DisplayType.MUSICA:
            musicaShop.add(shop);
          break;
          case DisplayType.PICOS:
            picosShop.add(shop);
          break;
          case DisplayType.PLAYSET_PROP:
            playSetProp.add(shop);
          break;
          case DisplayType.TRAJE:
            trajeShop.add(shop);
          break;
        default:
      }
    }

    add(OnLoadAllShopsEvent(
      alaDeltasShop: alaDeltasShop,
      envoltoriosShop: envoltoriosShop,
      gestosShop: gestosShop,
      loteDeObjetosShopCompletos: loteDeObjetosShopCompletos,
      musicaShop: musicaShop,
      picosShop: picosShop,
      playSetProp: playSetProp,
      trajeShop: trajeShop
    ));
  }


  void addShopElementsPaginate({required int indexShop, required List<Shop>? shop}) {
    List<Shop> newListShop = [];
    int i = indexShop + 20;
      for (i; i <= indexShop; i++) {
        newListShop.add(shop![i]); 
      }
    add(OnLoadShopDataEvent(newListShop: newListShop));
    add(OnUpdateIndexShopEvent(newIndex: indexShop + 20));
  }

  void setIndexSelectedItemShop(int i) => add(OnUpdateIndexShopEvent(newIndex: i)); //Añadade el indice del del elemento de la tienda que esta seleccinado;
  void setNewIndexChip(int i) => add(OnSetNewIndexChipEvent(newIndex: i)); //nuevo indice del chip tag seleccionado
}

// carguemos 10 items