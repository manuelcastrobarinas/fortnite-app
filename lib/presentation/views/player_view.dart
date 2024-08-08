import 'package:flutter/material.dart';
import 'package:fortnite_app/components/components.dart';

import '../../contants.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {

    final List<DropdownMenuEntry<String>> dropdownSeasonsList = [
      const DropdownMenuEntry(value: '30', label: 'TEMPORADA ACTUAL 30'),
      const DropdownMenuEntry(value: '29', label: 'TEMPORADA 29'),
      const DropdownMenuEntry(value: '28', label: 'TEMPORADA 28'),
      const DropdownMenuEntry(value: '27', label: 'TEMPORADA 27'),
      const DropdownMenuEntry(value: '26', label: 'TEMPORADA 26'),
    ];

    final Size size = MediaQuery.of(context).size;
    const TextStyle titleSection = TextStyle(color: kPrimaryTextColor, fontSize: 20);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: _DropdownSeasonsMenu(dropdownSeasonsList: dropdownSeasonsList)),
            const SizedBox(height: 10.0),
            Center(child: _ImageAndPlatforms(size: size)),
            const SizedBox(height: 10.0),
            const Center(child: _Username()),
            const SizedBox(height: 5),
            const _UserLevel(),
            const SizedBox(height: 20),
            const Text('Indice del Jugador', style: titleSection),
            const SizedBox(height: 10),
            const StadisticsComponentMultipleRows(
              listStadistics: <StadisticSection>[
                StadisticSection(title: 'K|D', description: 'Indice de kills|deaths', value: '1.46'),
                StadisticSection(title: 'W|R', description: 'ratio de Victorias', value: '0.03'),
                StadisticSection(title: 'Score', description: 'Puntaje Obtenido', value: '492.746')
              ],
            ),
            const SizedBox(height: 20),
            const Text('Top Obtenido en partidas', style: titleSection),
            const SizedBox(height: 10),
            const StadisticsComponentMultipleRows(
              radius: 20,
              listStadistics: <StadisticSection>[
                StadisticSection(title: '#1',   description: 'Victorias magístrales',   value: '6'),
                StadisticSection(title: '#3',   description: 'Top 3 de las partidas',   value: '25'),
                StadisticSection(title: '#5',   description: 'Top 5 de las partidas',   value: '30'),
                StadisticSection(title: '#10',  description: 'Top 10 de las partidas',  value: '60'),
                StadisticSection(title: '#12',  description: 'Top 12 de las partidas',  value: '150'),
                StadisticSection(title: '#25',  description: 'Top 25 de las partidas',  value: '400'),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Estadisticas generales', style: titleSection),
            const SizedBox(height: 10),
            const StadisticsComponentMultipleRows(
              listStadistics: <StadisticSection>[
                StadisticSection(title: 'Kills', description: 'Jugadores Eliminados', value: '3.780'),
                StadisticSection(title: '#Matches', description: 'Partidas Jugadas',  value: '2.682'),
                StadisticSection(title: '#Tiempo', description: 'Minutos Jugados',    value: '20.739')
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}


class _UserLevel extends StatelessWidget {
  const _UserLevel();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text('Nivel', style: TextStyle(color: Colors.black, fontSize: 26), overflow: TextOverflow.ellipsis, maxLines: 2),
        ),
        SizedBox(width: 10),
        SizedBox(
          child: Text('237', style: TextStyle(color: Colors.amber, fontSize: 32), overflow: TextOverflow.ellipsis, maxLines: 2),
        ),
      ],
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('Madavzcore', style: TextStyle(color: Colors.black, fontSize: 32), overflow: TextOverflow.ellipsis, maxLines: 2),
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