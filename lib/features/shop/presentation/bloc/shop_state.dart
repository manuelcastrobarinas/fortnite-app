part of 'shop_bloc.dart';

class ShopState extends Equatable {
  final int indexShop;
  final List<Shop> alaDeltasShop;
  final List<Shop> wrappersShop;
  final List<Shop> gesturesShop;
  final List<Shop> loteDeObjetosShopCompletos;
  final List<Shop> musicShop;
  final List<Shop> picosShop;
  final List<Shop> playSetProp;
  final List<Shop> skinsShop;
  final Shop? itemShopSelected;
  final int indexChipSelected;
  final int itemsPerPage;
  final bool isLoading;

  const ShopState({
    this.isLoading = false,
    this.indexShop = 1,
    this.itemsPerPage = 20,
    this.itemShopSelected,
    this.alaDeltasShop = const <Shop>[],
    this.wrappersShop = const <Shop>[],
    this.gesturesShop = const <Shop>[],
    this.loteDeObjetosShopCompletos = const <Shop>[],
    this.musicShop = const <Shop>[],
    this.picosShop = const <Shop>[],
    this.playSetProp = const <Shop>[],
    this.skinsShop = const <Shop>[],
    this.indexChipSelected = 0,
  });

  ShopState copyWith({
    int? indexShop,
    int? itemsPerPage,
    List<Shop>? alaDeltasShop,
    List<Shop>? wrappersShop,
    List<Shop>? gesturesShop,
    List<Shop>? loteDeObjetosShopCompletos,
    List<Shop>? musicShop,
    List<Shop>? picosShop,
    List<Shop>? playSetProp,
    List<Shop>? skinsShop,
    Shop? itemShopSelected,
    int? indexChipSelected,
    bool? isLoading,
  }) =>
      ShopState(
        indexShop: indexShop ?? this.indexShop,
        itemsPerPage: itemsPerPage ?? this.itemsPerPage,
        alaDeltasShop: alaDeltasShop ?? this.alaDeltasShop,
        wrappersShop: wrappersShop ?? this.wrappersShop,
        gesturesShop: gesturesShop ?? this.gesturesShop,
        loteDeObjetosShopCompletos:
            loteDeObjetosShopCompletos ?? this.loteDeObjetosShopCompletos,
        musicShop: musicShop ?? this.musicShop,
        picosShop: picosShop ?? this.picosShop,
        playSetProp: playSetProp ?? this.playSetProp,
        skinsShop: skinsShop ?? this.skinsShop,
        itemShopSelected: itemShopSelected ?? this.itemShopSelected,
        indexChipSelected: indexChipSelected ?? this.indexChipSelected,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [
        indexShop,
        itemsPerPage,
        alaDeltasShop,
        wrappersShop,
        gesturesShop,
        musicShop,
        picosShop,
        playSetProp,
        skinsShop,
        itemShopSelected,
        loteDeObjetosShopCompletos,
        indexChipSelected,
        isLoading,
      ];
}
