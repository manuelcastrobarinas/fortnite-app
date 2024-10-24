
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/blocs/player/player_bloc.dart';
import 'package:fortnite_app/models/players/player_stats.dart';

class SearchAccountDelegate extends SearchDelegate {

  SearchAccountDelegate(): super (searchFieldLabel: 'Ingresa el username de tu cuenta');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.clear ),
        onPressed: () =>  query = '' // limpia el texto 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) { //busqueda al darle clic en buscar, esto se ejectua 1 vez 
    final PlayerBloc playerbloc = BlocProvider.of<PlayerBloc>(context);
           
    return FutureBuilder(
      future: playerbloc.getPlayerAccount(userName: query),
      builder: (context, snapshot) {
      // print("hola mundo 2");
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (snapshot.connectionState == ConnectionState.none)    return const Center(child: Text("No hay conexión"));
        if (snapshot.hasError || snapshot.error == true)         return Center(child: Text(snapshot.error.toString()));
        if (snapshot.data != 'success') return Center(child: Text(snapshot.data.toString()));
        return   BlocBuilder<PlayerBloc, PlayerState>(
          builder:(context, PlayerState state) {
            final account = state.player;
            return Padding(
              padding : const EdgeInsets.symmetric( vertical: 20 ),
              child   : ListView.separated( //vamos a construir un ListView con la lsita de los lugares
                itemCount   : 1,
                itemBuilder : (context, i) {
                  return ListTile(          //retornamos un listTile con la informacion de cada uno de los lugares que existan en la busqueda
                    title   : Text( '${account!.name}' ),
                    leading : const Icon( Icons.account_circle, color: Colors.pink ),
                    onTap: () {
                      playerbloc.addNewPlayerSuggestion(newPlayerSuggestion: state.player!);
                      close(context, state.player);
                    }
                  );
                }, 
                separatorBuilder: ( _ , i) => const Divider(), 
              ),
            );
          }
        );
      },
    
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final PlayerBloc playerState = BlocProvider.of<PlayerBloc>(context);
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder:(context, PlayerState state) {
        final List<PlayerStatsModel> suggestionList = state.playerSuggestions;
        if (state.playerSuggestions.isEmpty) return _emptyContainer('No tienes sugerencias'); 
        return Padding(
          padding : const EdgeInsets.symmetric( vertical: 20 ),
          child   : ListView.separated( //vamos a construir un ListView con la lista de los jugadores buscados
            itemCount   : suggestionList.length,
            itemBuilder : (context, i) {
              return ListTile(  //retornamos un listTile con la informacion de cada uno de los jugadores guardados
                title   : Text( '${suggestionList[i].name}' ),
                leading : const Icon( Icons.account_circle_rounded, color: Colors.pink ),
                onTap: () {
                  playerState.setPlayerAccount(selectedPlayer: suggestionList[i]);
                  close(context, state.player);
                }
              );
            }, 
            separatorBuilder: ( _ , i) => const Divider(), 
          ),
        );
      }
    );
  }
}

 Widget _emptyContainer(String? text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.account_circle_rounded, color: Colors.black45,size: 150),
        Text('$text',style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}