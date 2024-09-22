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
    on<OnGetShopLimitedEvent>((event, emit) => emit(state.copyWith(shopLimited: event.shopLimited)));
  }

  Future<String> getShopLimited() async {
    final response = await shopServices.getShop();
    if (response != 'success') return response;
    add(OnGetShopLimitedEvent(shopLimited: shopServices.shopLimited!)); 
    return 'success';
  }
}
