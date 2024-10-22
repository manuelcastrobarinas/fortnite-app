part of 'shop_bloc.dart';

class ShopState extends Equatable {
  // final ShopLimited? shopAll; //contiene toda la informacion de la tienda
  //tienda paginada
  // final List<Shop> shopDataLoad; //contiene los items paginados que deseamos que se cargen en la pantalla para evitar fugas de memoria
  final int indexShop; 
  //TIENDAS SEPARADAS
  final List<Shop> alaDeltasShop; //contiene los aladeltas disponibles
  final List<Shop> envoltoriosShop; //contiene los envoltorios disponibles
  final List<Shop> gestosShop; //contiene los gestos disponibles
  final List<Shop> loteDeObjetosShopCompletos; //contiene los items del lote de 5, 4 y demas objetos disponibles
  final List<Shop> musicaShop; //contiene las pistas de musica disponibles
  final List<Shop> picosShop; //contiene los picos disponibles
  final List<Shop> playSetProp; //contiene los items de lego disponibles
  final List<Shop> trajeShop; //contiene los trajes disponibles
  //iterador de las tiendas
  final Shop? itemShopSelected;

  const ShopState({
    // this.shopAll,
    // this.shopDataLoad = const <Shop>[],
    this.indexShop = 0,
    this.itemShopSelected,
    this.alaDeltasShop      = const <Shop>[],
    this.envoltoriosShop    = const <Shop>[],
    this.gestosShop         = const <Shop>[],
    this.loteDeObjetosShopCompletos = const <Shop>[],
    this.musicaShop         = const <Shop>[],
    this.picosShop          = const <Shop>[],
    this.playSetProp        = const <Shop>[],
    this.trajeShop          = const <Shop>[],
  });

  ShopState copyWith({
    // ShopLimited? shopAll,
    List<Shop>? shopDataLoad,
    int? indexShop,
    List<Shop>? alaDeltasShop,
    List<Shop>? envoltoriosShop,
    List<Shop>? gestosShop,
    List<Shop>? loteDeObjetosShopCompletos,
    List<Shop>? musicaShop,
    List<Shop>? picosShop,
    List<Shop>? playSetProp,
    List<Shop>? trajeShop,
    Shop? itemShopSelected,
  }) => ShopState (
    // shopAll         : shopAll ?? this.shopAll,
    // shopDataLoad    : shopDataLoad ?? this.shopDataLoad,
    indexShop       : indexShop ?? this.indexShop,
    alaDeltasShop   : alaDeltasShop ?? this.alaDeltasShop,
    envoltoriosShop : envoltoriosShop ?? this.envoltoriosShop,
    gestosShop      : gestosShop ?? this.gestosShop,
    loteDeObjetosShopCompletos : loteDeObjetosShopCompletos ?? this.loteDeObjetosShopCompletos,
    musicaShop  : musicaShop  ?? this.musicaShop,
    picosShop   : picosShop   ?? this.picosShop,
    playSetProp : playSetProp ?? this.playSetProp,
    trajeShop   : trajeShop   ?? this.trajeShop,
    itemShopSelected: itemShopSelected ?? this.itemShopSelected,
  );

  @override
  List<Object?> get props => [
    // shopAll,
    // shopDataLoad, 
    indexShop,
    alaDeltasShop,
    envoltoriosShop,
    gestosShop,
    musicaShop,
    picosShop,
    playSetProp,
    trajeShop,
    itemShopSelected, 
  ];
}