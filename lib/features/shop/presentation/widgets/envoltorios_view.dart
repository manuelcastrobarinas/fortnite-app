import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/shop_offer_grid.dart';

class EnvoltoriosView extends StatelessWidget {
  const EnvoltoriosView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return ShopOfferGrid(
          offers: state.wrappersShop,
          title: 'Envoltorios Disponibles',
          emptyMessage: 'No hay envoltorios disponibles en la tienda',
        );
      },
    );
  }
}
