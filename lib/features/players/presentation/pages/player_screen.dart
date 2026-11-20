import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/scorebug.dart';
import 'package:fortnite_app/features/players/presentation/delegates/search_account.dart';

import 'package:fortnite_app/features/players/presentation/widgets/player_view.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state.player == null) {
            return Column(
              children: [
                Scorebug(
                  section: 'CUENTA',
                  subject: 'Busca una cuenta',
                  channel: kChannelPlayers,
                  trailing: IconButton(
                    tooltip: 'Buscar cuenta',
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () => showSearch(context: context, delegate: SearchAccountDelegate()),
                  ),
                ),
                const Expanded(child: _SearchAccountMessage()),
              ],
            );
          }
          return const PlayerView();
        },
      ),
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
