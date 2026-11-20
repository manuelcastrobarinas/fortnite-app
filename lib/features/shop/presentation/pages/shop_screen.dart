import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/error_retry_view.dart';
import 'package:fortnite_app/core/widgets/scorebug.dart';
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
      backgroundColor: kGround,
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          // return state.shopAll?.shop != null 
          return state.hasCatalog
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
    final List<String> choisesList = ['Lotes', 'ala Deltas', 'Picos', 'Skins', 'Envoltorios', 'Gestos', 'Sets Lego', 'Musica'];
    final index = state.indexChipSelected.clamp(0, choisesList.length - 1).toInt();
    return Column(
      children: [
        Scorebug(
          section: 'TIENDA',
          subject: choisesList[index],
          channel: kChannelShop,
        ),
        SizedBox(
          height: 56,
          child: ChoiceChipSelectComponent(
            choisesList: choisesList,
            defaultChoiseIndex: index,
            selectedColor: kChannelShop,
            onSelected: shopBloc.setNewIndexChip,
          ),
        ),
        Expanded(
          child: _setShopViewByTag(indexSelected: index),
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