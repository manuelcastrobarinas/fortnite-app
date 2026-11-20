import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/shop_offer_grid.dart';

class LotesView extends StatelessWidget {
  const LotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return ShopOfferGrid(
          offers: state.loteDeObjetosShopCompletos,
          title: 'Lotes de objetos',
          emptyMessage: 'No hay lotes disponibles en la tienda',
        );
      },
    );
  }
}
