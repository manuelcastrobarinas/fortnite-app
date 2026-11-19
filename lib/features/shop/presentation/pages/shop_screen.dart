import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/error_retry_view.dart';
import 'package:fortnite_app/core/widgets/painters/painters.dart';
import 'package:fortnite_app/core/widgets/widgets.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/ala_deltas_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/envoltorios_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/gestos_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/lego_items.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/lotes_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/musica_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/picos_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/skins_view.dart';

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
        // actions: <Widget>[
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black, size: 40,)),
        //   const SizedBox(width: 40.0)
        // ],
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

class _GetShopData extends StatefulWidget {
  final ShopState state;
  const _GetShopData({required this.state});

  @override
  State<_GetShopData> createState() => _GetShopDataState();
}

class _GetShopDataState extends State<_GetShopData> {
  Future<String>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= context.read<ShopBloc>().getShopLimited();
  }

  void _retry() {
    setState(() {
      _future = context.read<ShopBloc>().getShopLimited();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return ErrorRetryView(
            message: snapshot.error.toString(),
            onRetry: _retry,
          );
        }
        return _ShowShopView(state: widget.state);
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
          child: FadeInRight(
            duration: const Duration(milliseconds: 1200),
            child: ChoiceChipSelectComponent(
              choisesList: choisesList, 
              defaultChoiseIndex: state.indexChipSelected, 
              onSelected: shopBloc.setNewIndexChip
            ),
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
    if (indexSelected == 3) return const SkinsView();
    if (indexSelected == 4) return const EnvoltoriosView();
    if (indexSelected == 5) return const GestosView();
    if (indexSelected == 6) return const LegoView();
    return const MusicaView();
  }
}