import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/blocs/items/items_bloc.dart';
import 'package:fortnite_app/models/items/items.dart';

import '../utils/background_items_color.dart';

class SearchItemDelegate extends SearchDelegate {

  SearchItemDelegate(): super(searchFieldLabel: 'Ingresa el nombre de un Item');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget> [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: ()=> close(context, ''),
      icon: const Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final ItemsBloc itemsBloc = BlocProvider.of<ItemsBloc>(context);
    final List<Weapon> itemsList  = itemsBloc.state.items!.weapons!;
    final List<Weapon> matchItems = itemsList.where((weapon) => weapon.name != null && weapon.name!.toLowerCase().contains(query.toLowerCase())).toList();
    
    if(matchItems.isEmpty) return _emptyContainer('no se encontraron resultados');
    return ListView.builder(
      itemCount  : matchItems.length,
      itemBuilder: (BuildContext context, int i) {
        final Weapon item = matchItems[i];
        return _itemContainer(item, itemsBloc, context);
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ItemsBloc itemsBloc = BlocProvider.of<ItemsBloc>(context);
    final  List<Weapon> itemsList = itemsBloc.state.items!.weapons!;
    if (query.isEmpty) {      
      return ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (BuildContext context, int i) {
          final Weapon item = itemsList[i];
          return _itemContainer(item, itemsBloc, context);
        }
      );
    }

    final List<Weapon> matchItems = itemsList.where((weapon) => weapon.name != null && weapon.name!.toLowerCase().contains(query.toLowerCase())).toList();
    if(matchItems.isEmpty) return _emptyContainer('no se encontraron resultados');
    return ListView.builder(
      itemCount  : matchItems.length,
      itemBuilder: (BuildContext context, int i) {
        final Weapon item = matchItems[i];
        return _itemContainer(item, itemsBloc, context);
      }
    );
  }

  Padding _itemContainer(Weapon item, ItemsBloc itemsBloc, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: item.images?.background != null 
              ? NetworkImage(item.images!.background!) 
              : const AssetImage('assets/loading/vbuck.png')),
            title   : Text(item.name!),
            subtitle: Text(item.description ?? 'No Disponible', maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Text(item.rarity == null ?  'No disponible' : setRarityItemName(item.rarity!), style: TextStyle(color: setBackgroundItemColor(item.rarity!))),
            onTap: () {
              itemsBloc.setNewSelectedWapon(newSelectedWeapon: item);
              close(context, query);
            }
          ),
          const Divider()
        ],
      ),
    );
  }
}


 Widget _emptyContainer(String? text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.shopping_bag_sharp, color: Colors.black45,size: 150),
        Text('$text',style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}