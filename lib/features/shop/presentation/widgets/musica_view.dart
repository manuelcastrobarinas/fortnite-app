import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/shop_offer_grid.dart';

class MusicaView extends StatelessWidget {
  const MusicaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return ShopOfferGrid(
          offers: state.musicShop,
          title: 'Pistas disponibles',
          emptyMessage: 'No hay pistas disponibles en la tienda',
          crossAxisCount: 3,
        );
      },
    );
  }
}
