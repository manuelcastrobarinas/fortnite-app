import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/blocs/player/player_bloc.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/delegates/search_account.dart';
import 'package:fortnite_app/presentation/views/painters/left_waves_painter_view.dart';

import '../views/player_view.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          title: const Text('Estadisticas de Usuario', style: TextStyle(color: Colors.black, fontSize: 26)),
          toolbarHeight: 100,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 30),
              onPressed: () async => await showSearch(context: context, delegate: SearchAccountDelegate())
            ),
            const SizedBox(width: 20.0)
          ],
        ),
        body: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state.player == null) return const _SearchAccountMessage();
            return const _PlayerInformation();
          }
        )
      )
    );
  }
}

class _SearchAccountMessage extends StatelessWidget {
  const _SearchAccountMessage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image:AssetImage("assets/player/jonnesy.png"), fit: BoxFit.fill),
        Text("Busca la cuenta que deseas ver", style: TextStyle(fontSize: 22.0, overflow: TextOverflow.ellipsis),maxLines: 3),
      ],
    );
  }
}

class _PlayerInformation extends StatelessWidget {
  const _PlayerInformation();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        LeftWavesPainterView(colorWave: Colors.white),
        PlayerView(),
      ],
    );
  }
}