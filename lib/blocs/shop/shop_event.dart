part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class OnGetShopLimitedEvent extends ShopEvent { // evento para actualizar la data principal
  final ShopLimited shopLimited;

  const OnGetShopLimitedEvent({
    required this.shopLimited
  });
}

class OnSetSelectedShopItemEvent extends ShopEvent {// evento para seleccionar el item a mostrar
  final Shop newItemShop;

  const OnSetSelectedShopItemEvent({
    required this.newItemShop
  });
}

class OnLoadShopDataEvent extends ShopEvent { //evento que actualiza la tienda paginada
  final List<Shop> newListShop;

  const OnLoadShopDataEvent({
    required this.newListShop
  });
}

class OnUpdateIndexShopEvent extends ShopEvent { //EventO que actualiza la paginacion de la tienda(paginada)
  final int newIndex;
  const OnUpdateIndexShopEvent({required this.newIndex});
}

class OnLoadAllShopsEvent extends ShopEvent {
  final List<Shop> alaDeltasShop; 
  final List<Shop> envoltoriosShop;
  final List<Shop> gestosShop;
  final List<Shop> loteDeObjetosShopCompletos;
  final List<Shop> musicaShop;
  final List<Shop> picosShop;
  final List<Shop> playSetProp;
  final List<Shop> trajeShop;

  const OnLoadAllShopsEvent({
    required this.alaDeltasShop,
    required this.envoltoriosShop,
    required this.gestosShop,
    required this.loteDeObjetosShopCompletos,
    required this.musicaShop,
    required this.picosShop,
    required this.playSetProp,
    required this.trajeShop,
  });
}