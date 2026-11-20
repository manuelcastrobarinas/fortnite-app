import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/shop_offer_grid.dart';

class GestosView extends StatelessWidget {
  const GestosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return ShopOfferGrid(
          offers: state.gesturesShop,
          title: 'Gestos disponibles',
          emptyMessage: 'No existen gestos disponibles en la tienda',
        );
      },
    );
  }
}
