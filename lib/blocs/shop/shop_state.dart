part of 'shop_bloc.dart';

class ShopState extends Equatable {

  final ShopLimited? shopLimited;

  const ShopState({
    this.shopLimited
  });

  ShopState copyWith({
    ShopLimited? shopLimited,
  }) => ShopState (
    shopLimited: shopLimited ?? this.shopLimited
  );

  @override
  List<Object?> get props => [shopLimited];
}
