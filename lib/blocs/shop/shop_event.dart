part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class OnGetShopLimitedEvent extends ShopEvent {
  final ShopLimited shopLimited;

  const OnGetShopLimitedEvent({
    required this.shopLimited
  });
}
