import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views.dart';
import 'package:fortnite_app/presentation/views/painters/painters.dart';

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
            ? _ShowShopView(state: state)
            : _GetShopData(state: state);
        }
      )
    );
  }
}

class _GetShopData extends StatelessWidget {
  final ShopState state;
  const _GetShopData({
    required this.state
  });

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
        return  _ShowShopView(state: state);
      },
    );
  }
}

class _ShowShopView extends StatelessWidget {
  final ShopState state;
  const _ShowShopView({
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context);
    final List<String> choisesList =  ['Lotes', 'ala Deltas', 'Picos', 'Skins', 'Envoltorios', 'Gestos', 'Sets Lego', 'Musica'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: ChoiceChipSelectComponent(
            choisesList: choisesList, 
            defaultChoiseIndex: state.indexChipSelected, 
            onSelected: shopBloc.setNewIndexChip
          )
        ),  
        Flexible(
          flex: 7,
          fit: FlexFit.loose,
          child: Stack(
            children: [
              const LeftWavesPainterView(colorWave: kBackgroundColor),
              _setShopViewByTag(indexSelected: state.indexChipSelected)
            ],
          ),
        ),
      ],
    );
  }

  Widget _setShopViewByTag({required int indexSelected}) {
    if (indexSelected == 0) return const LotesView();
    if (indexSelected == 1) return const AlaDeltaView();
    if (indexSelected == 2) return const PicosView();
    if (indexSelected == 3) return const LotesView();
    if (indexSelected == 4) return const LotesView();
    if (indexSelected == 5) return const LotesView();
    if (indexSelected == 6) return const LotesView();
    return const LotesView();
  }
}