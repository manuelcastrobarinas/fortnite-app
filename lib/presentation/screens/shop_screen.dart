import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views/painters/painters.dart';
import 'package:fortnite_app/presentation/views/shop/lotes_view.dart';

import '../../blocs/shop/shop_bloc.dart';
import '../../components/components.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Tienda Hoy', style: TextStyle(color: Colors.black, fontSize: 38), maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black, size: 40,)),
          const SizedBox(width: 40.0)
        ],
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          // return state.shopAll?.shop != null 
          return state.loteDeObjetosShopCompletos.isNotEmpty
            ? const _ShowShopView()
            : const _GetShopData();
        }
      )
    );
  }
}

class _GetShopData extends StatelessWidget {
  const _GetShopData();

  @override
  Widget build(BuildContext context) {
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context);
    return FutureBuilder(
      future  : shopBloc.getShopLimited(),
      builder : (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.connectionState == ConnectionState.none)    return const Center(child: Text("No hay conexión"));
        if (snapshot.hasError || snapshot.error == true)         return Center(child: Text(snapshot.error.toString()));
        if (snapshot.data != 'success') return Center(child: Text(snapshot.data.toString()));
        return const _ShowShopView();
      },
    );
  }
}

class _ShowShopView extends StatelessWidget {
  const _ShowShopView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: TagsMultipleChipSelectorComponent()
        ),  
        Flexible(
          flex: 7,
          fit: FlexFit.loose,
          child: Stack(
            children: [
              LeftWavesPainterView(colorWave: kBackgroundColor),
              LotesView(),
            ],
          ),
        ),
      ],
    );
  }
}
