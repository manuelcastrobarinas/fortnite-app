import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/core/widgets/scorebug.dart';
import 'package:fortnite_app/core/widgets/widgets.dart';

import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/features/players/presentation/delegates/search_account.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> choisesList = ['Solo','Duos','Trios','Escuadrones'];

    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        // final List<DropdownMenuEntry<String>> dropdownSeasonsList = [
        //   const DropdownMenuEntry(value: '30', label: 'TEMPORADA ACTUAL 30'),
        //   const DropdownMenuEntry(value: '29', label: 'TEMPORADA 29'),
        //   const DropdownMenuEntry(value: '28', label: 'TEMPORADA 28'),
        //   const DropdownMenuEntry(value: '27', label: 'TEMPORADA 27'),
        //   const DropdownMenuEntry(value: '26', label: 'TEMPORADA 26'),
        // ];

        List<StadisticSection> indexPlayerStats = <StadisticSection>[
          StadisticSection(title: 'K|D', description: 'Indice de kills|deaths', value: state.selectedStats?["kd"].toString() ?? 'no'),
          StadisticSection(title: 'W|R', description: 'ratio de Victorias', value: state.selectedStats?["winrate"].toString()  ?? 'no'),
          StadisticSection(title: 'Score', description: 'Puntaje Obtenido', value: state.selectedStats?["score"].toString()  ?? 'no')
        ];

        List<StadisticSection> topGames = <StadisticSection>[
          StadisticSection(title: '#1',   description: 'Victorias magístrales',   value: state.selectedStats?["winrate"].toString() ?? 'no'),
          StadisticSection(title: '#3',   description: 'Top 3 de las partidas',   value: state.selectedStats?["placetop3"].toString() ?? 'no'),
          StadisticSection(title: '#5',   description: 'Top 5 de las partidas',   value: state.selectedStats?["placetop5"].toString() ?? 'no'),
          StadisticSection(title: '#10',  description: 'Top 10 de las partidas',  value: state.selectedStats?["placetop10"].toString() ?? 'no'),
          StadisticSection(title: '#12',  description: 'Top 12 de las partidas',  value: state.selectedStats?["placetop12"].toString() ?? 'no'),
          StadisticSection(title: '#25',  description: 'Top 25 de las partidas',  value: state.selectedStats?["placetop25"].toString() ?? 'no'),
        ];


        List<StadisticSection> generalStats = <StadisticSection>[
          StadisticSection(title: 'Kills', description: 'Jugadores Eliminados', value: state.selectedStats?["kills"].toString() ?? 'no'),
          StadisticSection(title: '#Matches', description: 'Partidas Jugadas',  value: state.selectedStats?["matchesplayed"].toString() ?? 'no'),
          StadisticSection(title: '#Tiempo', description: 'Minutos Jugados',    value: state.selectedStats?["minutesplayed"].toString() ?? 'no')
        ];

        const titleSection = TextStyle(color: kInk, fontSize: 16, fontWeight: FontWeight.w700);
        final name = state.player?.name ?? 'Sin nombre';
        return Column(
          children: [
            Scorebug(
              section: 'CUENTA',
              subject: name,
              channel: kChannelPlayers,
              trailing: IconButton(
                tooltip: 'Buscar cuenta',
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () => showSearch(context: context, delegate: SearchAccountDelegate()),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16),
                const Center(child: _ImageAndPlatforms()),
                const SizedBox(height: 8),
                _UserLevel(level: state.player?.account?.level?.toString() ?? '-'),
                if (state.player?.globalStats == null) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'La cuenta sí aparece. Las cifras (K/D, victorias) piden una llave gratuita de fortnite-api.com en PUBLIC_API_KEY.',
                    style: TextStyle(color: kPrimaryTextColor, fontSize: 14),
                  ),
                ],
                const SizedBox(height: 10),
                _ChoiceChipSelectedTeam(
                  choisesList: choisesList,
                  defaultChoiseIndex: state.selectTeamOption,
                  playerState: state,
                ),
                const SizedBox(height: 10),
                const Text('Indice del Jugador', style: titleSection),
                const SizedBox(height: 10),
                StadisticsComponentMultipleRows(
                  listStadistics: indexPlayerStats
                ),
                const SizedBox(height: 20),
                const Text('Top Obtenido en partidas', style: titleSection),
                const SizedBox(height: 10),
                StadisticsComponentMultipleRows(
                  radius: 20,
                  listStadistics:topGames
                ),
                const SizedBox(height: 20),
                const Text('Estadisticas generales', style: titleSection),
                const SizedBox(height: 10),
                StadisticsComponentMultipleRows(
                  listStadistics: generalStats
                ),
                const SizedBox(height: 16),
              ],
            ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class _UserLevel extends StatelessWidget {
  final String level;

  const _UserLevel({
    required this.level
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Nivel', style: TextStyle(color: kInk, fontSize: 16)),
        const SizedBox(width: 8),
        Text(
          level,
          style: const TextStyle(
            color: kInk,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _ImageAndPlatforms extends StatelessWidget {
  const _ImageAndPlatforms();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 112,
      height: 112,
      child: Image(
        image: AssetImage('assets/player/jonnes.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}


// ignore: unused_element
class _DropdownSeasonsMenu extends StatelessWidget {
  const _DropdownSeasonsMenu({
    required this.dropdownSeasonsList,
  });

  final List<DropdownMenuEntry<String>> dropdownSeasonsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: kPrimaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0,2),
            blurRadius: 2
          )
        ]
      ),
      child: DropdownMenu(      
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.none
            ),
          )
        ),
        trailingIcon: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.keyboard_arrow_down, color: kPrimaryColor)
        ),
        textStyle : const TextStyle(color: Colors.white, fontSize: 20),
        hintText  : 'elige la temporada',
        width : MediaQuery.of(context).size.width * 0.5,   
        menuStyle : const MenuStyle(  
          backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft  : Radius.circular(30),
                bottomRight : Radius.circular(30),
                topLeft     : Radius.circular(10), 
                topRight    : Radius.circular(10), 
              ),
            ),
                
          )
        ),
        dropdownMenuEntries: dropdownSeasonsList,
        enabled: true,
        onSelected: (value) {},
      ),
    );
  }
}


class _ChoiceChipSelectedTeam extends StatelessWidget {

  final int defaultChoiseIndex;
  final PlayerState playerState;
  final List<String> choisesList; //LISTA DE ELEMENTOS PARA CADA UNO DE LOS CHOISE

  const _ChoiceChipSelectedTeam({
    required this.choisesList,
    required this.defaultChoiseIndex,
    required this.playerState
  });

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Wrap(
            spacing: 10.0,
            children: List.generate(choisesList.length, (index) {
                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    choisesList[index],
                    style: TextStyle(color: defaultChoiseIndex == index ? Colors.white : kInk),
                  ),
                  selected: defaultChoiseIndex == index,
                  selectedColor: kChannelPlayers,
                  backgroundColor: kQuiet,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  onSelected: (value) {
                      playerBloc.changeTeamOption(
                      newTeamOption: index, 
                      selectedStats: setTeamStats(index, playerState)
                    );
                  },
                );
              } 
            ),
          ),
        )
      ),
    );
  }

  Map<String, double>? setTeamStats(int index, PlayerState state) {
    final stats = state.player?.globalStats;
    if (stats == null) return null;
    if (index == 0) return stats.solo;
    if (index == 1) return stats.duo;
    if (index == 2) return stats.trio;
    return stats.squad;
  }
}