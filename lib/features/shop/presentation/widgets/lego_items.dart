import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/shop_offer_grid.dart';

class LegoView extends StatelessWidget {
  const LegoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return ShopOfferGrid(
          offers: state.playSetProp,
          title: 'Set de Lego disponibles',
          emptyMessage: 'No hay sets de Lego disponibles en la tienda',
        );
      },
    );
  }
}
