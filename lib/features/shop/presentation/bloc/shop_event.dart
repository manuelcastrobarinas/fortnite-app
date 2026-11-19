part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class OnSetSelectedShopItemEvent extends ShopEvent {
  final Shop newItemShop;

  const OnSetSelectedShopItemEvent({required this.newItemShop});
}

class OnUpdateIndexShopEvent extends ShopEvent {
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

class OnSetNewIndexChipEvent extends ShopEvent {
  final int newIndex;

  const OnSetNewIndexChipEvent({required this.newIndex});
}

class OnLoadMoreElementsEvent extends ShopEvent {
  final int page;
  final int itemsPerPage;

  const OnLoadMoreElementsEvent({
    required this.page,
    required this.itemsPerPage,
  });
}
