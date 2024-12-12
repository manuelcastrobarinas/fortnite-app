part of 'shop_bloc.dart';

class ShopState extends Equatable {
  // final ShopLimited? shopAll; //contiene toda la informacion de la tienda
  //tienda paginada
  // final List<Shop> shopDataLoad; //contiene los items paginados que deseamos que se cargen en la pantalla para evitar fugas de memoria
  final int indexShop; 
  //TIENDAS SEPARADAS
  final List<Shop> alaDeltasShop; //contiene los aladeltas disponibles
  final List<Shop> wrappersShop; //contiene los envoltorios disponibles
  final List<Shop> gesturesShop; //contiene los gestos disponibles
  final List<Shop> loteDeObjetosShopCompletos; //contiene los items del lote de 5, 4 y demas objetos disponibles
  final List<Shop> musicShop; //contiene las pistas de musica disponibles
  final List<Shop> picosShop; //contiene los picos disponibles
  final List<Shop> playSetProp; //contiene los items de lego disponibles
  final List<Shop> skinsShop; //contiene los trajes disponibles
  //iterador de las tiendas
  final Shop? itemShopSelected;
  //indice del tag del chip Seleccionado
  final int indexChipSelected;
  final int itemsPerPage;
  final bool isLoading;

  const ShopState({
    // this.shopAll,
    // this.shopDataLoad = const <Shop>[],
    this.isLoading = false,
    this.indexShop = 1,
    this.itemsPerPage = 20,
    this.itemShopSelected,
    this.alaDeltasShop      = const <Shop>[],
    this.wrappersShop    = const <Shop>[],
    this.gesturesShop         = const <Shop>[],
    this.loteDeObjetosShopCompletos = const <Shop>[],
    this.musicShop         = const <Shop>[],
    this.picosShop          = const <Shop>[],
    this.playSetProp        = const <Shop>[],
    this.skinsShop          = const <Shop>[],
    this.indexChipSelected = 0,
  });

  ShopState copyWith({
    // ShopLimited? shopAll,
    List<Shop>? shopDataLoad,
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
    bool? isLoading
  }) => ShopState (
    // shopAll         : shopAll ?? this.shopAll,
    // shopDataLoad    : shopDataLoad ?? this.shopDataLoad,
    indexShop       : indexShop ?? this.indexShop,
    itemsPerPage    : itemsPerPage ?? this.itemsPerPage,
    alaDeltasShop   : alaDeltasShop ?? this.alaDeltasShop,
    wrappersShop : wrappersShop ?? this.wrappersShop,
    gesturesShop      : gesturesShop ?? this.gesturesShop,
    loteDeObjetosShopCompletos : loteDeObjetosShopCompletos ?? this.loteDeObjetosShopCompletos,
    musicShop  : musicShop  ?? this.musicShop,
    picosShop   : picosShop   ?? this.picosShop,
    playSetProp : playSetProp ?? this.playSetProp,
    skinsShop   : skinsShop   ?? this.skinsShop,
    itemShopSelected: itemShopSelected ?? this.itemShopSelected,
    indexChipSelected: indexChipSelected ?? this.indexChipSelected,
    isLoading: isLoading ?? this.isLoading
  );

  @override
  List<Object?> get props => [
    // shopAll,
    // shopDataLoad, 
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
    isLoading
  ];
}