import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/components/components.dart';

import '../../blocs/player/player_bloc.dart';
import '../../contants.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> choisesList = ['Solo','Duos','Trios','Escuadrones'];

    final Size size = MediaQuery.of(context).size;
    const TextStyle titleSection = TextStyle(color: kPrimaryTextColor, fontSize: 20);

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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Center(child: _DropdownSeasonsMenu(dropdownSeasonsList: dropdownSeasonsList)),
                const SizedBox(height: 10.0),
                Center(child: _ImageAndPlatforms(size: size)),
                const SizedBox(height: 10.0),
                Center(child: _Username(userName: state.player!.name!,)),
                const SizedBox(height: 5),
                _UserLevel(level: state.player!.account!.level.toString()),
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
                const SizedBox(height: 10),
              ],
            ),
          ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          child: Text('Nivel', style: TextStyle(color: Colors.black, fontSize: 26), overflow: TextOverflow.ellipsis, maxLines: 2),
        ),
        const SizedBox(width: 10),
        SizedBox(
          child: Text(level, style: const TextStyle(color: Colors.amber, fontSize: 32), overflow: TextOverflow.ellipsis, maxLines: 2),
        ),
      ],
    );
  }
}

class _Username extends StatelessWidget {
  final String userName;
  const _Username({
    required this.userName
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(userName, style: const TextStyle(color: Colors.black, fontSize: 32), overflow: TextOverflow.ellipsis, maxLines: 2),
    );
  }
}

class _ImageAndPlatforms extends StatelessWidget {
  final Size size;
  
  const _ImageAndPlatforms({
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : size.width * 0.34,
      height: size.width * 0.40,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: kPrimaryTextColor,
            radius: size.height * 0.40,
          ),
          SizedBox(
            height: size.width * 0.40,
            width : size.width * 0.34,
            child: const Image(image: AssetImage('assets/player/jonnes.png'),fit: BoxFit.cover,)),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width : double.infinity,
              height: size.height * 0.034,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Platform(size: size, backgroundColor: Colors.black, isConsole: false),
                  _Platform(size: size, backgroundColor: Colors.black38, isConsole: true),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Platform extends StatelessWidget {
  final Size size;
  final Color backgroundColor;
  final bool isConsole;

  const _Platform({
    required this.size,
    required this.backgroundColor,
    required this.isConsole
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.034,
      width : size.height * 0.034,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: const <BoxShadow> [
          BoxShadow(
            offset: Offset(0, 3),
            color : Colors.black45,
          )
        ],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: isConsole == true 
        ? const Icon(Icons.gamepad, color: Colors.white)
        : const Text("PC", style: TextStyle(color: Colors.white, fontSize: 22))
      )
    );
  }
}


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
                  labelPadding: const EdgeInsets.all(2.0),
                  label: Text(choisesList[index], style: const TextStyle(color: Colors.white)), 
                  selected: defaultChoiseIndex == index,
                  selectedColor: kPrimaryColor,
                  disabledColor: kPrimaryColorVariant,
                  backgroundColor: kPrimaryColorVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
    if (index == 0) return state.player!.globalStats!.solo;
    if (index == 1) return state.player!.globalStats!.duo;
    if (index == 2) return state.player!.globalStats!.trio;
   return state.player!.globalStats!.squad;
  }
}